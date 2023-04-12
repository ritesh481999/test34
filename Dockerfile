FROM ubuntu:20.04 AS base
WORKDIR /app
RUN apt-get update
RUN apt install wget -y
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get update 
RUN apt-get install -y dotnet-sdk-6.0
COPY . .
RUN dotnet build "DeploymentPOC/DeploymentPOC.csproj"
EXPOSE 5281
ENTRYPOINT ["dotnet", "run", "--project=DeploymentPOC/DeploymentPOC.csproj"]