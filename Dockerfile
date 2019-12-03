FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

# Install production dependencies.
# Copy csproj and restore as distinct layers.
WORKDIR /app
COPY ./Logging .

# Copy local code to the container image.
COPY . .

# Build a release artifact.
RUN dotnet publish -c Release -o out

# Make sure the app binds to port 8080
ENV ASPNETCORE_URLS http://*:8080

# Run the web service on container startup.
CMD ["dotnet", "Logging.dll"]
