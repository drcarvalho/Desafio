  345  docker build -t drcarvalho/desafioglobo-local:2 .
  346  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  347  docker push drcarvalho/desafioglobo-local:2

  docker run -p 8000:8000 610a9b999550 

  daniel@daniel-Inspiron-3437:~/Desktop/Desafio$ curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
* Host localhost:8000 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8000...
* Connected to localhost (::1) port 8000
> POST /api/comment/new HTTP/1.1
> Host: localhost:8000
> User-Agent: curl/8.5.0
> Accept: */*
> Content-Type: application/json
> Content-Length: 101
> 
< HTTP/1.1 200 OK
< Server: gunicorn/20.0.4
< Date: Thu, 16 May 2024 05:29:40 GMT
< Connection: close
< Content-Type: application/json
< Content-Length: 92
< 
{
  "message": "comment created and associated with content_id 1", 
  "status": "SUCCESS"
}
* Closing connection
daniel@daniel-Inspiron-3437:~/Desktop/Desafio$ curl -sv localhost:8000/api/comment/list/1
* Host localhost:8000 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8000...
* Connected to localhost (::1) port 8000
> GET /api/comment/list/1 HTTP/1.1
> Host: localhost:8000
> User-Agent: curl/8.5.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: gunicorn/20.0.4
< Date: Thu, 16 May 2024 05:29:55 GMT
< Connection: close
< Content-Type: application/json
< Content-Length: 109
< 
[
  {
    "comment": "ok, now I am gonna say something more useful", 
    "email": "alice@example.com"
  }
]
* Closing connection
daniel@daniel-Inspiron-3437:~/Desktop/Desafio$ 