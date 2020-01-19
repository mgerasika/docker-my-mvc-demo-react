set port=8082
set image=my-mvc-demo-react
set app=my-mvc-demo-react-%port%
docker build -t %image% .
docker stop %app%
docker rm %app%
docker run --env PORT=80 -d -p %port%:80 --name %app% %image%