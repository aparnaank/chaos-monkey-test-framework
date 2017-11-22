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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

/**
 * This is the Microservice resource class.
 * See <a href="https://github.com/wso2/msf4j#getting-started">https://github.com/wso2/msf4j#getting-started</a>
 * for the usage of annotations.
 *
 * @since 0.1-SNAPSHOT
 */

public class ScriptExecutorUtil {
    private static final org.apache.commons.logging.Log log = LogFactory.getLog(ScriptExecutorUtil.class);

    public static void processOutputGenerator(String[] command) throws IOException {

        ProcessBuilder processBuilder = new ProcessBuilder(command);

        try {
            Process process = processBuilder.start();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream(),
                    StandardCharsets.UTF_8))){
                String line;
                log.info(" Listing Run Output .... " + Arrays.toString(command) + " is: ");
                while ((line = br.readLine()) != null) {
                    log.info(line);
                }
            } catch (IOException e) {
                log.error("Error while printing process output : " + e.getMessage(), e);
            }
        }catch (IOException e) {
            log.error("Error while trying to execute the command : " + e.getMessage(), e);
        }

    }
}
