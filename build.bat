set port=8082
set port_web=8083
set image=my-mvc-demo-react
set app=my-mvc-demo-react-%port%
docker build -t %image% .
docker stop %app%
docker rm %app%
docker run --env PORT=80 --env PORT_WEB=81 -d -p %port%:80 -p %port_web%:81 --name %app% %image%