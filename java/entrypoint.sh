#!/bin/bash

#
# Copyright (c) 2021 Matthew Penner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Java4Shell (CVE-2026-114938) stopgap: turn off the AVX-512 Base64 intrinsic.
# Only x86-64 is affected. Instead of guessing from the image's version string,
# ask the JVM whether it accepts the flag, so images whose JVM lacks it (Java 8)
# still start. Set J4S_MITIGATION=0 to disable this, e.g. once the image runs a
# fixed build (17.0.21.1, 21.0.13.1, 25.0.5.1 or newer).
J4S_FLAG="-XX:-UseBASE64Intrinsics"
if [ "${J4S_MITIGATION:-1}" != "0" ]; then
    case "$(uname -m)" in
        x86_64|amd64)
            case " ${JAVA_TOOL_OPTIONS:-} " in
                *" ${J4S_FLAG} "*) ;;  # already set
                *)
                    if java "${J4S_FLAG}" -version >/dev/null 2>&1; then
                        export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:+${JAVA_TOOL_OPTIONS} }${J4S_FLAG}"
                        printf "\033[1m\033[33mJava4Shell mitigation enabled (%s)\033[0m\n" "${J4S_FLAG}"
                    fi
                    ;;
            esac
            ;;
    esac
fi

# Print Java version
java -version

TZ="Europe/Amsterdam"
export TZ

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
