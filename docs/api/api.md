---
title: Raito API
nav_exclude: true
permalink: /docs/api
---

# Raito API

## Using the Raito API

Raito uses [GraphQL](https://graphql.org/) as its API paradigm. No official public API is available at this point. However, this document describes some GraphQL queries that can be used to do retrieve some standard information and perform standard tasks.
We will use [Postman](https://www.postman.com/) to describe how queries should be executed.

## Setting up Postman

Raito uses token based authentication. This means that a token needs to be acquired from the identity store first. This token is then used to authentication against the API.

To make things easier, we will do this by using Pre-request Scripts in Postman.

### Creating an environment

The cleanest way, is to use environments in Postman. Environments are a set of variables to be used when writing requests.

1. In Postman, go to `Environments`
2. Click `+` to create a new one and give it a good name. For example, `Raito`
3. Create the following variables:
    1. CLIENT_ID: leave the type on `default`. The Initial Value should be the client id of your Raito instance. You can request this from Raito via [support@raito.io](mailto://support@raito.io)
    2. USERNAME: leave the type on `default`. The Initial Value should be the username of the Raito user you want to use to do the requests. This user needs to have the correct permissions to execute the Graphql queries you want.
    3. PASSWORD: set the type to ‘secret’. The Initial Value should be the password for the user.
        ![Environment](/assets/images/api/environment.png)
        
4. Make sure to `Save` the environment like this

### Creating a collection

Next, we’ll create a Collection and implement the script to fetch the authentication token to pass on every request.

1. In Postman, go to `Collections`
2. Click on `+` to add a new Collection and give it a good name. For example, `Raito`
3. In the `Pre-request Script` tab, enter the following script:

```jsx
const echoPostRequest = {
  url: 'https://cognito-idp.eu-central-1.amazonaws.com/',
  method: 'POST',
  header: {
    'Content-Type': 'application/x-amz-json-1.1',
    'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth'
  },
  body: {
    mode: 'application/json',
    raw: JSON.stringify(
      {
        "AuthParameters": {
          "USERNAME": pm.environment.get("USERNAME"),
          "PASSWORD": pm.environment.get("PASSWORD")
        },
        "AuthFlow": "USER_PASSWORD_AUTH",
        "ClientId": pm.variables.get('CLIENT_ID')
      })
  }
};

var getToken = true;
if (!pm.environment.get('ACCESS_TOKEN_EXPIRY') || !pm.environment.get('ACCESS_TOKEN')) {
  console.log('Token or expiry date are missing')
} else if (pm.environment.get('ACCESS_TOKEN_EXPIRY') <= (new Date()).getTime()) {
  console.log('Token is expired')
} else {
  getToken = false;
  console.log('Token and expiry date are all good');
}

if (getToken === true) {
  pm.sendRequest(echoPostRequest, function (err, res) {
    console.log(err ? err : res.json());
    if (err === null) {
      console.log('Saving the token: '+responseJson)
      var responseJson = res.json();
      pm.environment.set('ACCESS_TOKEN', responseJson.AuthenticationResult.IdToken)

      var expiryDate = new Date();
      expiryDate.setSeconds(expiryDate.getSeconds() + responseJson.AuthenticationResult.ExpiresIn);
      pm.environment.set('ACCESS_TOKEN_EXPIRY', expiryDate.getTime());
    }
  });
}
```

Make sure to click `Save`.

### Executing a request

Now, we are ready to try out a first request.

1. Hover over the name of the collection you just created in the list on the right
2. Click the `…` (three dots)
3. Click the `Add Request` action in the popup menu
4. Give the request a name. For example, `Raito Test`.
5. Switch the HTTP method to `POST`
6. Fill in the request URL: https://api.raito.cloud/query
7. In the `Headers` tab, add an additional header with key `Authorization` and value `token {{COGNITO_ACCESS_TOKEN}}`. The header section should then look something like this:
    
    ![Headers](/assets/images/api/headers.png)
    
8. In the Body tab, select the type ‘GraphQL’ and enter your first GraphQL query. For example:

```graphql
query Test {
    currentUser {
        name
    }
}
```

Postman also supports fetching the GraphQL schema so that it can provide auto-complete functionality while editing the request body. You can do this by clicking the ‘refresh’ icon as seen on the bottom-right of this screenshot (if it didn’t already automatically fetch it):

![Request](/assets/images/api/request.png)

## Fetching the Schema

Outside of the Postman auto-complete feature, you can also do an introspection query to know what queries, mutations, fields, … are available. We do this in exactly the same way as any other GraphQL query. Instead of the request body of the text example above, now use this query instead:

```graphql
# eslint-disable @graphql-eslint/naming-convention
query Introspection {
  __schema {
    queryType {
      name
    }
    mutationType {
      name
    }
    types {
      ...FullType
    }
    directives {
      name
      description
      locations
      args {
        ...InputValue
      }
    }
  }
}

fragment FullType on __Type {
  kind
  name
  description
  fields(includeDeprecated: true) {
    name
    description
    args {
      ...InputValue
    }
    type {
      ...TypeRef
    }
    isDeprecated
    deprecationReason
  }
  inputFields {
    ...InputValue
  }
  interfaces {
    ...TypeRef
  }
  enumValues(includeDeprecated: true) {
    name
    description
    isDeprecated
    deprecationReason
  }
  possibleTypes {
    ...TypeRef
  }
}
fragment InputValue on __InputValue {
  name
  description
  type {
    ...TypeRef
  }
  defaultValue
}
fragment TypeRef on __Type {
  kind
  name
  ofType {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
              }
            }
          }
        }
      }
    }
  }
}
```

<aside>
🚫 Please note that most of these queries, mutations, and types are not public API and so are subject to change.

</aside>

## Examples

### Fetching Access Providers

In the following query, we fetch the first 10 AccessProviders that contain the string `TEST`. For each of these AccessProviders, we also get the first 10 users that this AccessProvider provides access to.

```graphql
query GetAccessProviders {
    accessProviders(limit: 10, filter: {search: "TEST"}) {
        ... on PagedResult {
            edges {
                node {
                    ... on AccessProvider {
                        name
                        whoUsers(limit: 10) {
                            ... on PagedResult {
                                edges {
                                    node {
                                        __typename
                                        ... on AccessWhoItem {
                                            item {
                                                ... on User {
                                                    name
                                                    email
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
```

### Adding users to an AccessProvider

To add users to an Access Provider, the mutation `addWhoToAccessProvider` is provided. 

In the example below, we’ll add the user with id `user123` to the access provider with id `abc123`.

```graphql
mutation AddWhoToAccessProvider($input: [WhoItemInput!]) {
    addWhoToAccessProvider(id: "abc123", toAdd: $input) {
        ... on AccessProvider {
            name
        }
    }
}
```

Here we make use of variables, so in the GraphQL variables field in Postman, enter the JSON that will represent the `[WhoItemInput!]` input array:

```json
{
    "input": [
        {
            "user": "user123"
        }
    ]
}
```

### Removing users from an AccessProvider

Similarly, we can also remove users from an Access Provider using mutation `removeWhoFromAccessProvider`. 

In the example below, we’ll remove the user with id `user123` from the access provider with id `abc123`.

```graphql
mutation RemoveWhoFromAccessProvider {
    removeWhoFromAccessProvider(id: "abc123", toRemove: ["user123"]) {
        ... on AccessProvider {
            name
        }
    }
}
```