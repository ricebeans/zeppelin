#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Run Zeppelin 
#

bin=$(dirname "${BASH_SOURCE-$0}")
bin=$(cd "${bin}">/dev/null; pwd)

. "${bin}/common.sh"


ZEPPELIN_INSTALL_INTERPRETER_MAIN=org.apache.zeppelin.interpreter.install.InstallInterpreter
ZEPPELIN_LOGFILE="${ZEPPELIN_LOG_DIR}/install-interpreter.log"
JAVA_OPTS+=" -Dzeppelin.log.file=${ZEPPELIN_LOGFILE}"

if [[ -d "${ZEPPELIN_HOME}/zeppelin-zengine/target/classes" ]]; then
  ZEPPELIN_CLASSPATH+=":${ZEPPELIN_HOME}/zeppelin-zengine/target/classes"
fi
addJarInDir "${ZEPPELIN_HOME}/zeppelin-server/target/lib"

if [[ -d "${ZEPPELIN_HOME}/zeppelin-interpreter/target/classes" ]]; then
  ZEPPELIN_CLASSPATH+=":${ZEPPELIN_HOME}/zeppelin-interpreter/target/classes"
fi
addJarInDir "${ZEPPELIN_HOME}/zeppelin-interpreter/target/lib"

addJarInDir "${ZEPPELIN_HOME}/lib"

CLASSPATH+=":${ZEPPELIN_CLASSPATH}"
$ZEPPELIN_RUNNER $JAVA_OPTS -cp $CLASSPATH $ZEPPELIN_INSTALL_INTERPRETER_MAIN ${@}
