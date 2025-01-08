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

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

const string CLIENT_ID = "bf7aa889-a677-4a76-93a6-c6b9fc896ff3";
const string CLIENT_SECRET = "5b1ce2fe-0634-4055-ab9c-3bffe7efa00c";
const string REFRESH_TOKEN = "na1-2d3a-d4fb-4043-8229-7a7d9fc128df";

OAuth2RefreshTokenGrantConfig auth = {
    clientId: CLIENT_ID,
    clientSecret: CLIENT_SECRET,
    refreshToken: REFRESH_TOKEN,
    credentialBearer: oauth2:POST_BODY_BEARER
};

// Global Client configuration for HTTP communication
ConnectionConfig config = { 
    httpVersion: http:HTTP_2_0, 
    timeout: 60, 
    auth: auth 
};

// HubSpot CRM Client for interacting with HubSpot's Object Schemas API
final Client hpClient = check new Client(config, "https://api.hubapi.com/crm-object-schemas/v3/schemas");

// Test: Get Schema - Fetches a list of object schemas
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchemas() returns error? {
    // Make GET request to fetch schemas
    CollectionResponseObjectSchemaNoPaging response = check hpClient->/crm\-object\-schemas/v3/schemas;

    // Assert that the response is of type CollectionResponseObjectSchemaNoPaging
    test:assertTrue(response is CollectionResponseObjectSchemaNoPaging, "Expected response to be of type CollectionResponseObjectSchemaNoPaging");
}

// Test: Create Schema - Creates a new schema
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateSchema() returns error? {
    // Define the payload for creating a new object schema
    ObjectSchemaEgg payload = {
        "secondaryDisplayProperties": ["string"],
        "requiredProperties": ["my_object_property"],
        "searchableProperties": ["string"],
        "primaryDisplayProperty": "my_object_property",
        "name": "my_object",
        "description": "string",
        "associatedObjects": ["CONTACT"],
        "properties": [],
        "labels": {
            "plural": "My objects",
            "singular": "My object"
        }
    };

    // Make POST request to create the schema
    ObjectSchema response = check hpClient->/crm\-object\-schemas/v3/schemas.post(payload);

    // Assert that the response is of type ObjectSchema
    test:assertTrue(response is ObjectSchema, "Expected response to be of type ObjectSchema");
}

// Test: Delete Schema - Deletes a specific schema by its ID
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteSchema() returns error? {
    // Define the object schema ID to delete
    string objId = "testid";

    // Make DELETE request to delete the schema
    http:Response response = check hpClient->/crm\-object\-schemas/v3/schemas/[objId].delete();

    // Assert that the response is of type http:Response
    test:assertTrue(response is http:Response, "Expected response to be of type http:Response");
}

// Test: Update Schema - Updates an existing schema by ID
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPatchSchema() returns error? {
    // Define the payload for updating an object schema
    ObjectSchemaEgg payload = {
        "secondaryDisplayProperties": ["string"],
        "requiredProperties": ["my_object_property"],
        "searchableProperties": ["string"],
        "primaryDisplayProperty": "my_object_property",
        "name": "my_object",
        "description": "string",
        "associatedObjects": ["CONTACT"],
        "properties": [],
        "labels": {
            "plural": "My objects",
            "singular": "My object"
        }
    };

    // Define the object schema ID to patch
    string objId = "testid2";

    // Make PATCH request to update the schema
    ObjectTypeDefinition response = check hpClient->/crm\-object\-schemas/v3/schemas/[objId].patch(payload);

    // Assert that the response is of type ObjectTypeDefinition
    test:assertTrue(response is ObjectTypeDefinition, "Expected response to be of type ObjectTypeDefinition");
}