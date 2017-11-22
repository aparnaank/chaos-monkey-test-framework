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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import java.io.File;
import java.io.IOException;
import java.util.Map;

import static org.wso2.chaosmonkey.agent.ScriptExecutorUtil.processOutputGenerator;

/**
 * This is the Microservice resource class.
 * See <a href="https://github.com/wso2/msf4j#getting-started">https://github.com/wso2/msf4j#getting-started</a>
 * for the usage of annotations.
 *
 * @since 0.1-SNAPSHOT
 */
@Path("/chaos")
public class ChaosService {

    private static final Log log = LogFactory.getLog(ChaosService.class);

    /*
    * Server terminating function
    * */
    @POST
    @Path("/terminate/{instance}")
    public String terminateServer(@PathParam("instance") String instance) {

        String scriptLocation="/home/ubuntu/chaotic-patterns/instance-app-failures";
        //Shell file name needs to be executed
        String shellfile="instanceAppFailures.sh";
        String[] command = new String[]{"/bin/bash",scriptLocation + File.separator + shellfile,"-k" + instance};

        try {
            processOutputGenerator(command);
        }
        catch (IOException e) {
            log.error("Error while trying to run instanceAppFailures shell script with server termination: " + e.getMessage(), e);
        }
        return "Done!!!";
    }

    /*
    * Server start-up, restart, shutdown function
    * */
    @POST
    @Path("/revive/{operation}")
    public String reviveServer(@PathParam("operation") String operation) {
        System.out.println("Starting server : " + operation);
        String scriptLocation="/home/ubuntu/chaotic-patterns/instance-app-failures";
        //Shell file name needs to be executed
        String shellfile="instanceAppFailures.sh";
        String instancePath="/home/ubuntu/km/wso2am-2.1.0";
        String[] command = new String[]{"/bin/bash",scriptLocation + File.separator + shellfile,"-p" + instancePath, "-o" + operation};

        try {
            processOutputGenerator(command);
        }
        catch (IOException e) {
            log.error("Error while trying to run instanceAppFailures shell script with server termination: " + e.getMessage(), e);
        }
        return "Done!!!";
    }


    /*
    * Increasing CPU utilization function
    * */
    @POST
    @Path("/cpu/{cpu}/duration/{time}")
    public String highCPU(@PathParam("cpu") String cpu, @PathParam("time") String time){

        String scriptLocation="/home/ubuntu/chaotic-patterns/server-stressing";
        //Shell file name needs to be executed
        String shellfile="makeStress.sh";
        String[] command = new String[]{"/bin/bash",scriptLocation + File.separator + shellfile,"-c" + cpu, "-t" + time};

        try {
            processOutputGenerator(command);
        }
        catch (IOException e) {
            log.error("Error while trying to run stress shell CPU parameters : " + e.getMessage(), e);
        }
        return "Done!!!";
    }

    /*
    * Increasing IO utilization function
    * */
    @POST
    @Path("/io/{io}/duration/{time}")
    public String highIO(@PathParam("io") String io, @PathParam("time") String time){

        String scriptLocation="/home/ubuntu/chaotic-patterns/server-stressing";
        //Shell file name needs to be executed
        String shellfile="makeStress.sh";
        String[] command = new String[]{"/bin/bash",scriptLocation + File.separator + shellfile,"-i" + io, "-t" + time};

        try {
            processOutputGenerator(command);
        }
        catch ( IOException e){
            log.error("Error while trying to run stress shell with IO parameters : " + e.getMessage(), e);
        }
        return "Done    !!!";
    }

    /*
    * Increasing IO utilization function
    * */
    @POST
    @Path("/blockserelets/{servport}")
    public String blockServerletPorts(@PathParam("servport") String servport){

        String scriptLocation="/home/ubuntu/chaotic-patterns/network-fluctuation";
        //Shell file name needs to be executed
        String shellfile="makeNetworkFluctuation.sh";
        String[] command = new String[]{"/bin/bash",scriptLocation + File.separator + shellfile,"-s" + servport};

        try {
            processOutputGenerator(command);
        }
        catch ( IOException e){
            log.error("Error while trying to run stress shell with IO parameters : " + e.getMessage(), e);
        }
        return "Done    !!!";
    }
}
