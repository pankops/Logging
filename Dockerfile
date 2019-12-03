# First let�s build the app and publish it. 
FROM gcr.io/cloud-builders/csharp/dotnet AS builder 
COPY /src WORKDIR /src 
RUN dotnet restore --packages /packages 
RUN dotnet publish -c Release -o /published 
# Now let's build the app's image. 
FROM gcr.io/google-appengine/aspnet:3.0
COPY --from=builder /published /app 
ENV ASPNETCORE_URLS=http://*:${PORT} 
WORKDIR /app ENTRYPOINT [ "dotnet", "logging.dll" ]