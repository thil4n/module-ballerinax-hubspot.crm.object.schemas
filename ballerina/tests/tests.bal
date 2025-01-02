// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/http;
import ballerina/io;
import ballerina/oauth2;

const string CLIENT_ID = "bf7aa889-a677-4a76-93a6-c6b9fc896ff3";
const string CLIENT_SECRET = "5b1ce2fe-0634-4055-ab9c-3bffe7efa00c";
const string REFRESH_TOKEN = "5b1ce2fe-0634-4055-ab9c-3bffe7efa00c";



   OAuth2RefreshTokenGrantConfig auth = {
       clientId: CLIENT_ID,
       clientSecret: CLIENT_SECRET,
       refreshToken: REFRESH_TOKEN,
       credentialBearer: oauth2:POST_BODY_BEARER 
   };



// Global Client instance
ConnectionConfig config = {httpVersion: http:HTTP_2_0, timeout: 60,auth: auth};

final Client hpClient = check new Client(config, "http://127.0.0.1:3000");




@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetSchemas() returns error? {

    

    
    // Mock API response for GET request
    string objectType = "custom_object_type";
    string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";



    CollectionResponseObjectSchemaNoPaging response = check hpClient->/crm\-object\-schemas/v3/schemas;


    io:print(response);


    // test:assertTrue(response is http:Response);

}

// @test:Config {
//     groups: ["live_tests", "mock_tests"]
// }

// isolated function testCreateSchema() returns error? {
//     // Mock API response for POST request
//     string resourcePath = "/crm-object-schemas/v3/schemas";


//     // Testing POST request for creating schema
//     ObjectSchemaEgg payload = new; // Mock payload
//     var response = hpClient.post(resourcePath, payload);
//     test:assertTrue(response is http:Response);
//     http:Response actualResponse = <http:Response>response;
//     json payloadResponse = check actualResponse.getJsonPayload();
//     test:assertEquals(payloadResponse.status.toString(), "created");
//     test:assertEquals(payloadResponse.id.toString(), "12345");
// }

// @test:Config {
//     groups: ["live_tests", "mock_tests"]
// }

// isolated function testDeleteSchema() returns error? {
//     // Mock API response for DELETE request
//     string objectType = "custom_object_type";
//     string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";


//     // Testing DELETE request for schema
//     var response = hpClient.delete(resourcePath);
//     test:assertTrue(response is http:Response);
//     http:Response actualResponse = <http:Response>response;
//     json payloadResponse = check actualResponse.getJsonPayload();
//     test:assertEquals(payloadResponse.status.toString(), "deleted");
// }

// @test:Config {
//     groups: ["live_tests", "mock_tests"]
// }

// isolated function testPatchSchema() returns error? {
//     // Mock API response for PATCH request
//     string objectType = "custom_object_type";
//     string resourcePath = "/crm-object-schemas/v3/schemas/${objectType}";


//     // Testing PATCH request for schema update
//     ObjectTypeDefinitionPatch payload = new; // Mock payload
//     var response = hpClient.patch(resourcePath, payload);
//     test:assertTrue(response is http:Response);
//     http:Response actualResponse = <http:Response>response;
//     json payloadResponse = check actualResponse.getJsonPayload();
//     test:assertEquals(payloadResponse.status.toString(), "updated");
// }

