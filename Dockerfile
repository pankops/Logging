FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

ENV ASPNETCORE_URLS http://*:5000

RUN mkdir /opt/app

ADD output /opt/app

RUN apt-get update && \
apt-get remove -y curl sqlite3 \
&& apt autoremove -y 

RUN apt-get update && \
apt-get upgrade -y && \
rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" dotnetuser

USER dotnetuser

CMD ["dotnet", "opt/app/Logging.dll"]