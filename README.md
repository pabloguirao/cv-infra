Aquí tienes el contenido completo para copiar y pegar:
markdown# cv-infra
Infraestructura como código (IaC) para desplegar mi currículum personal en AWS usando Terraform.

El currículum está disponible en: [pabloguirao/mi-cv](https://github.com/pabloguirao/mi-cv)

---

## Arquitectura

![esquema](images/arquitectura.png)

---

## Requisitos previos

| Herramienta | Versión | Instalación |
|---|---|---|
| Terraform | v1.14.7 | [HashiCorp docs](https://developer.hashicorp.com/terraform/install) |
| AWS CLI | v2.34.14 | [AWS docs](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) |

### Configuración de credenciales AWS

Crear un usuario IAM en la consola de AWS con las siguientes políticas en línea:

- **S3**: CreateBucket, DeleteBucket, PutBucketPolicy, PutBucketWebsite, PutBucketPublicAccessBlock, PutObject, GetObject, DeleteObject, ListBucket
- **CloudFront**: CreateDistribution, GetDistribution, UpdateDistribution, DeleteDistribution, TagResource, CreateOriginAccessControl, GetOriginAccessControl, DeleteOriginAccessControl
- **IAM**: CreateServiceLinkedRole (limitado al rol de servicio de CloudFront)

Una vez creado el usuario, generar un **Access Key** y configurarlo en WSL:
```bash
aws configure
```

Introducir cuando lo solicite:
- AWS Access Key ID
- AWS Secret Access Key
- Default region: `eu-south-2`
- Default output format: 

Verificar que las credenciales funcionan correctamente:
```bash
aws sts get-caller-identity
```

---

## Estructura del proyecto
```
cv-infra/
├── main.tf          # Recursos principales (S3 + CloudFront)
├── variables.tf     # Variables reutilizables
├── outputs.tf       # Outputs de Terraform (URL, etc.)
├── providers.tf     # Configuración del proveedor AWS
├── images           # Carpeta con imagenes
└── README.md        # Este archivo
```

---

## Cómo desplegar

### 1. Inicializar Terraform
Descarga los providers necesarios:
```bash
terraform init
```
### 2. Crear la infraestructura
Previsualiza los cambios antes de aplicar:
```bash
terraform plan
```
Aplica los cambios:
```bash
terraform apply
```
### 3. Subir los archivos del CV a S3
Sincroniza los archivos del repositorio mi-cv con el bucket:
```bash
aws s3 sync /ruta/a/mi-cv s3://cv-pabloguirao --exclude ".git/*" --exclude "README.md" --exclude ".gitignore"
```

Para verificar que se han subido correctamente:
```bash
aws s3 ls s3://cv-pabloguirao --recursive
```

Para actualizar el CV en el futuro, edita los archivos en mi-cv y vuelve a ejecutar el sync.

---

## Problemas conocidos y soluciones

**Permisos de escritura en WSL sobre discos de Windows**
Al trabajar con WSL sobre carpetas creadas con PowerShell como administrador,
WSL no tiene permisos de escritura. Solución: dar permisos al usuario desde
Propiedades → Seguridad → Control total en Windows.

**Permisos IAM insuficientes en el primer apply**
El usuario IAM inicial no tenía todos los permisos necesarios para que
Terraform pudiera hacer el apply. Se añadieron los
permisos necesarios.

---

## Autor

**Pablo Guirao**  
[github.com/pabloguirao](https://github.com/pabloguirao)