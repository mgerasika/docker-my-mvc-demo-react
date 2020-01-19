# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
# WORKDIR /app

# # Copy csproj and restore as distinct layers
# COPY *.csproj ./
# RUN dotnet restore

# # Copy everything else and build
# COPY . ./
# RUN dotnet publish -c Release -o out

# # Build runtime image
# FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
# WORKDIR /app
# COPY --from=build-env /app/out .
# CMD ["dotnet", "my-mvc-demo-react.dll"]

#node
FROM node:11.15.0 as builder

COPY ClientApp/. /app-web/
WORKDIR /app-web/

RUN npm install
RUN npm run build

FROM nginx:latest
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/$PORT_WEB/'"$PORT_WEB"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
COPY --from=builder /app-web/public /var/www/dist