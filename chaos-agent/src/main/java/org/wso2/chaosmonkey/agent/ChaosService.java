/*
 * Copyright (c) 2016, WSO2 Inc. (http://wso2.com) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.wso2.chaosmonkey.agent;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import java.util.Map;

/**
 * This is the Microservice resource class.
 * See <a href="https://github.com/wso2/msf4j#getting-started">https://github.com/wso2/msf4j#getting-started</a>
 * for the usage of annotations.
 *
 * @since 0.1-SNAPSHOT
 */
@Path("/chaos")
public class ChaosService {

    @POST
    @Path("/terminate/{instance}")
    public String terminateServer(@PathParam("instance") String instance) {
        System.out.println("Terminating instance : " + instance);
        return "Done!!!";
    }

    @POST
    @Path("/revive/{instance}")
    public String reviveServer(@PathParam("instance") String instance) {
        System.out.println("Starting server : " + instance);
        return "Done!!!";
    }

    @POST
    @Path("/cpu/{cpu}/duration/{time}")
    public String highCPU(@PathParam("cpu") String cpu, @PathParam("time") String time){
        System.out.println("High CPU utilization : " + cpu);
        System.out.println("High CPU utilize duration : " + time);

        try {
            ProcessBuilder pb =
                    new ProcessBuilder("/home/aparna/QAHackathon/chaos-monkey-test-framework/chaotic-patterns/server-stressing/makeStress.sh", "-c", "-t");
            Map<String, String> env = pb.environment();
            env.put("-c", cpu);
            env.put("-t", time);
            Process p = pb.start();
            //int i = p.waitFor();
            System.out.println("Script executed successfully");
            System.out.println("Test:" + pb );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Done!!!";
    }
}
