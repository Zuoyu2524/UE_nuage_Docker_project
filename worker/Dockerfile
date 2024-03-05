FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:7.0 AS build
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo $TARGETPLATFORM \
    && echo $TARGETARCH \
    && echo BUILDPLATFORM 
WORKDIR /source 

COPY . .

RUN dotnet restore -a $TARGETARCH
RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore

FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
CMD [ "dotnet", "Worker.dll"]
