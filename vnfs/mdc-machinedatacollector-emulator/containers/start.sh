#!/bin/bash
# Copyright (c) 2018 5GTANGO, Weidmüller, Paderborn University
# ALL RIGHTS RESERVED.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Neither the name of the SONATA-NFV, 5GTANGO, Weidmüller, Paderborn University
# nor the names of its contributors may be used to endorse or promote
# products derived from this software without specific prior written
# permission.
#
# This work has also been performed in the framework of the 5GTANGO project,
# funded by the European Commission under Grant number 761493 through
# the Horizon 2020 and 5G-PPP programmes. The authors would like to
# acknowledge the contributions of their colleagues of the SONATA
# partner consortium (www.5gtango.eu).

# 1. set route to RTR
route add -net $NETNS1 gw $GATEWAY dev $IFLOCAL
echo "MDC: Configured route to NS1 over RTR:"
route -n

echo "MDC: Starting SAMBA server ... (logs: /var/smb.log)"
smbd -F -d verbose --log-stdout > /var/smb.log &

echo "MDC: Starting MDC VNF APP ... (logs: /var/mdc.log)"
cd /MDC_VNF
python3 MDC_VNF.py > /var/mdc.log &

# for debugging, we can use this simple MQTT generator
# echo "MDC: Starting MQTT generator ..."
# ./mqtt_generator.sh &
