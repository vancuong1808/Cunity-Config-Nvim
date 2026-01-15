# .NET CLI MASTER CHEATSHEET

> Mục tiêu: **Master dotnet CLI** đủ để làm **Web API, Clean Architecture, Microservices, CI/CD** mà **không phụ thuộc IDE**.

---

## 0. Nguyên tắc cốt lõi

* `dotnet` = entrypoint duy nhất
* **Project (.csproj)** là đơn vị build
* **Solution (.sln)** chỉ để quản lý nhiều project
* Mọi wizard IDE đều quy về **dotnet CLI + file config**

---

## 1. Kiểm tra môi trường

```bash
dotnet --info
dotnet --version
dotnet --list-sdks
dotnet --list-runtimes
```

---

## 2. Template & khởi tạo project

### 2.1 Liệt kê template

```bash
dotnet new list
dotnet new list --type project
dotnet new list --language C#
```

### 2.2 Khởi tạo nhanh

```bash
dotnet new webapi -n MyApi
dotnet new classlib -n MyLib
dotnet new console -n MyApp
dotnet new sln -n MySolution
```

### 2.3 Khởi tạo có option quan trọng

```bash
dotnet new webapi \
  -n MyApi \
  --framework net8.0 \
  --use-controllers \
  --no-https \
  --auth None
```

> ⚠️ **dotnet new không tạo Solution tự động**

---

## 3. Solution (.sln) management

```bash
dotnet new sln -n App
dotnet sln add src/App.Api/App.Api.csproj
dotnet sln remove src/App.Api/App.Api.csproj
dotnet sln list
```

---

## 4. Project reference & dependency

### 4.1 Add project reference

```bash
dotnet add reference ../Core/Core.csproj
```

### 4.2 Remove reference

```bash
dotnet remove reference ../Core/Core.csproj
```

### 4.3 NuGet package

```bash
dotnet add package MediatR
dotnet remove package MediatR
dotnet list package
```

---

## 5. Restore – Build – Run – Test

```bash
dotnet restore
dotnet build
dotnet run
dotnet test
```

### 5.1 Theo cấu hình

```bash
dotnet build -c Release
dotnet run --environment Development
```

---

## 6. Publish & Deployment

### 6.1 Publish cơ bản

```bash
dotnet publish -c Release -o ./publish
```

### 6.2 Publish self-contained

```bash
dotnet publish \
  -c Release \
  -r win-x64 \
  --self-contained true
```

### 6.3 Linux Docker-ready

```bash
dotnet publish -c Release -r linux-x64 --no-self-contained
```

---

## 7. Runtime & Hosting

### 7.1 Kestrel

```bash
dotnet run --urls=http://localhost:5000
```

### 7.2 Environment variable

```bash
ASPNETCORE_ENVIRONMENT=Production dotnet run
```

---

## 8. Entity Framework Core

### 8.1 Tool

```bash
dotnet tool install --global dotnet-ef
dotnet ef --version
```

### 8.2 Migration

```bash
dotnet ef migrations add Init
dotnet ef database update
dotnet ef migrations remove
```

### 8.3 Multi-project

```bash
dotnet ef migrations add Init \
  --project Infrastructure \
  --startup-project Api
```

---

## 9. User Secrets & Config

```bash
dotnet user-secrets init
dotnet user-secrets set "Jwt:Key" "secret"
dotnet user-secrets list
```

---

## 10. Tooling & Global tools

```bash
dotnet tool list -g
dotnet tool install -g dotnet-format
dotnet tool update -g dotnet-ef
```

---

## 11. Diagnostics & Debug

```bash
dotnet run --verbosity detailed
dotnet build -bl
dotnet trace collect
```

---

## 12. Clean Architecture – cấu trúc chuẩn

```text
src/
 ├─ Api
 ├─ Application
 ├─ Domain
 ├─ Infrastructure
```

```bash
dotnet new classlib -n Domain
dotnet new classlib -n Application
dotnet new classlib -n Infrastructure
dotnet new webapi -n Api
```

---

## 13. CI/CD cơ bản

```bash
dotnet restore
dotnet build -c Release
dotnet test -c Release
dotnet publish -c Release
```

---

## 14. Các lệnh ít người biết nhưng rất mạnh

```bash
dotnet workload list
dotnet workload install wasm-tools
dotnet msbuild /t:Restore
dotnet clean
dotnet nuget locals all --clear
```

---

## 15. Mental Model (rất quan trọng)

* `.csproj` = source of truth
* `.sln` = optional
* CLI > IDE
* Template chỉ là **scaffold**, không phải *magic*
