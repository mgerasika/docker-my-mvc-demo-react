
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
ENV ASPNETCORE_ENVIRONMENT Production
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# #React build
# FROM node:11.15.0 as nodebuilder

# # set working directory
# RUN mkdir /usr/src/web-app
# WORKDIR /usr/src/web-app

# # add `/usr/src/app/node_modules/.bin` to $PATH
# ENV PATH /usr/src/web-app/node_modules/.bin:$PATH


# # install and cache app dependencies
# COPY ClientApp/package.json /usr/src/web-app/package.json
# RUN npm install

# # add app

# COPY ClientApp/. /usr/src/web-app

# RUN npm run build

# #End React build

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/out .

# #react copy
# RUN mkdir -p /app/out/ClientApp/dist
# #COPY --from=nodebuilder /usr/src/web-app/dist/ClientApp/. /app/out/ClientApp/dist/
# #end react copy
ENV ASPNETCORE_ENVIRONMENT Production
CMD ["dotnet", "my-mvc-demo-react.dll"]