# User 

## Endpoints 
| HTTP method | endpoint |                     usage                     |
| :---------: | :------: | :-------------------------------------------: |
| GET         | /users/me| Get the current user                          |
| GET         |/users/:id| Get the user with the given ID                |
| POST        | /user    | Create a new user                             |
| PATCH       | /user    | Updates the current user                      |
| DELETE      | /user    | Delete current user from the data base        |

## HTTP status codes
200: Ok

400: Bad request (Invalid input), error message is provided, can be accessed from the JSON object by using 'error' key.
     There can be more than one errors in a request but the 'error' key only shows one.

401: Unauthorized, token and refresh token that were sent through were invalid.

403: Forbidden, session token was not sent through with the request.

404: User was not found.

# Rescue Request 

## Endpoints 
| HTTP method | endpoint |                     usage                     |
| :---------: | :------: | :-------------------------------------------: |
| GET         | /rr/all  |Gets all rescue requests which are currently open|
| GET         | /rr/:id  | Gets rescue request with the given id         |
| POST        | /rr      | Creates a new rescue request                  |
| PATCH       | /rr/:id  | Update the rescue request with the given id   |
| PATCH       |/rr/:id/close| Close a resolved rescue request            |
| DELETE      | /rr/:id  | Delete a rescue request                       |

## HTTP status codes
200: Ok

400: Bad request (Invalid input), error message is provided, can be accessed from the JSON object by using 'error' key.
     There can be more than one errors in a request but the 'error' key only shows one.

401: Unauthorized, token and refresh token that were sent through were invalid.

403: Forbidden, session token was not sent through with the request.

404: Rescue request post was not found.