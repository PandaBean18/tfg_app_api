# Http status codes 
Status codes are added in the JSON object and can be accessed by using 'status' key
## User 
200: Ok
400: Bad request (Invalid input), error message is provided, can be accessed from the JSON object by using 'error' key.
     There can be more than one errors in a request but the 'error' key only shows one.
403: Forbidden, session token was not sent through with the request.
404: User was not found.