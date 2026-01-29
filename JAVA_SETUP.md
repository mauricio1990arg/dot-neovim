# Configuración de Neovim para Java, Spring Boot y Lombok

## 📋 Requisitos Previos

Antes de usar esta configuración, asegúrate de tener instalado:

### 1. Java Development Kit (JDK)
```bash
# Verifica si tienes Java instalado
java -version

# Si no lo tienes, instala JDK 17 o superior (recomendado para Spring Boot 3.x)
# En Ubuntu/Debian:
sudo apt update
sudo apt install openjdk-17-jdk

# En Fedora:
sudo dnf install java-17-openjdk-devel

# En Arch:
sudo pacman -S jdk17-openjdk
```

### 2. Maven o Gradle
```bash
# Maven
sudo apt install maven  # Ubuntu/Debian
sudo dnf install maven  # Fedora
sudo pacman -S maven    # Arch

# O Gradle
sudo apt install gradle  # Ubuntu/Debian
sudo dnf install gradle  # Fedora
sudo pacman -S gradle    # Arch
```

### 3. Lombok JAR (Automático con Mason)
Mason descargará automáticamente Lombok, pero si quieres instalarlo manualmente:
```bash
# Descarga Lombok
wget https://projectlombok.org/downloads/lombok.jar -O ~/.local/share/nvim/mason/packages/jdtls/lombok.jar
```

## 🚀 Instalación

### Paso 1: Reinicia Neovim
```bash
nvim
```

### Paso 2: Instala los plugins
Cuando abras Neovim, Lazy.nvim instalará automáticamente todos los plugins. Si no se instalan automáticamente:
```vim
:Lazy sync
```

### Paso 3: Instala las herramientas con Mason
```vim
:Mason
```

Mason instalará automáticamente:
- ✓ jdtls (Java Language Server)
- ✓ java-debug-adapter
- ✓ java-test
- ✓ lua-language-server
- ✓ json-lsp
- ✓ yaml-language-server
- ✓ lemminx (XML Language Server para Maven/Spring)

Si alguno no está instalado, presiona `i` sobre el paquete para instalarlo manualmente.

### Paso 4: Configura Lombok para tu proyecto
**IMPORTANTE**: Para que Lombok funcione correctamente, necesitas generar un archivo `lombok.config` en tu proyecto.

Abre tu proyecto Java y ejecuta:
```vim
:JavaSetupLombok
```

Esto creará un archivo `lombok.config` en la raíz de tu proyecto. Este paso es **necesario** para que jdtls reconozca las anotaciones de Lombok.

### Paso 5: Verifica la configuración
Abre un archivo Java:
```bash
cd tu-proyecto-java
nvim src/main/java/com/ejemplo/Main.java
```

El LSP debería iniciarse automáticamente. Verifica con:
```vim
:LspInfo
```

Deberías ver `jdtls` en la lista de clientes LSP activos.

## 📁 Estructura de Archivos Creados

```
~/.config/nvim/
├── lua/
│   ├── core/
│   │   └── java-helpers.lua   # Comandos helper para Java
│   └── plugins/
│       ├── mason.lua          # Gestor de LSP y herramientas
│       ├── java-lsp.lua       # Configuración de jdtls con Lombok
│       ├── dap.lua            # Debugger para Java
│       └── luasnip.lua        # Snippets de Spring Boot
├── init.lua                   # Configuración principal
└── JAVA_SETUP.md              # Esta guía
```

## 🛠️ Comandos Personalizados

- `:JavaSetupLombok` - Genera `lombok.config` en la raíz del proyecto actual
- `:JavaGenerateLombokConfig` - Genera `lombok.config` en el workspace de jdtls
- `:Mason` - Abre el gestor de herramientas Mason
- `:LspInfo` - Muestra información sobre los LSP activos

## ⌨️ Atajos de Teclado

### LSP (Language Server Protocol)
- `gD` - Ir a declaración
- `gd` - Ir a definición
- `K` - Mostrar documentación (hover)
- `gi` - Ir a implementación
- `<C-k>` - Mostrar firma de función
- `<leader>rn` - Renombrar símbolo
- `<leader>ca` - Acciones de código
- `gr` - Mostrar referencias
- `<leader>f` - Formatear código

### Java específico
- `<leader>jo` - Organizar imports
- `<leader>jv` - Extraer variable (normal y visual)
- `<leader>jc` - Extraer constante (normal y visual)
- `<leader>jm` - Extraer método (visual)
- `<leader>tc` - Ejecutar test de clase
- `<leader>tm` - Ejecutar test del método actual

### Debugging
- `<F5>` - Iniciar/Continuar debug
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Breakpoint condicional
- `<leader>dr` - Abrir REPL
- `<leader>du` - Toggle UI de debug

### Snippets (en modo INSERT)
- `controller` + Tab - Crear RestController
- `getmapping` + Tab - Crear GET endpoint
- `postmapping` + Tab - Crear POST endpoint
- `putmapping` + Tab - Crear PUT endpoint
- `deletemapping` + Tab - Crear DELETE endpoint
- `service` + Tab - Crear Service
- `repository` + Tab - Crear Repository
- `entity` + Tab - Crear Entity con Lombok
- `lombok` + Tab - Clase con anotaciones Lombok
- `autowired` + Tab - Inyección de dependencias
- `config` + Tab - Clase de configuración
- `springbootapp` + Tab - Clase principal de Spring Boot
- `test` + Tab - Método de test
- `<C-L>` - Siguiente campo del snippet
- `<C-H>` - Campo anterior del snippet

## 🔧 Características

### ✅ Soporte completo para Lombok
- Reconocimiento de `@Data`, `@Getter`, `@Setter`, `@Builder`, etc.
- Autocompletado de métodos generados por Lombok
- Sin errores de "método no encontrado"

### ✅ Spring Boot
- Autocompletado de anotaciones Spring
- Navegación entre componentes
- Validación de configuración en `application.properties` y `application.yml`
- Soporte para XML de Maven y Gradle

### ✅ Debugging
- Breakpoints visuales
- Inspección de variables
- Step debugging
- Hot code replace (cambios en caliente)

### ✅ Testing
- Ejecutar tests desde Neovim
- Integración con JUnit 5
- Cobertura de código

## 🐛 Solución de Problemas

### El LSP no inicia
```vim
:LspInfo
:LspLog
```
Verifica que Java esté en tu PATH:
```bash
which java
echo $JAVA_HOME
```

### Lombok no funciona
**Solución 1**: Genera el archivo `lombok.config` (MUY IMPORTANTE)
```vim
:JavaSetupLombok
```

Este comando crea un archivo `lombok.config` en la raíz de tu proyecto, que es **necesario** para que jdtls reconozca Lombok.

**Solución 2**: Verifica que el JAR de Lombok esté presente:
```bash
ls -la ~/.local/share/nvim/mason/packages/jdtls/lombok.jar
```

Si no existe, reinstala jdtls:
```vim
:Mason
```
Busca `jdtls`, presiona `X` para desinstalar y luego `i` para reinstalar.

### Mason no instala paquetes
```vim
:checkhealth mason
```

Asegúrate de tener `git`, `curl` y `unzip` instalados:
```bash
sudo apt install git curl unzip  # Ubuntu/Debian
```

### El workspace de Java está corrupto
Elimina el workspace y reinicia:
```bash
rm -rf ~/.local/share/nvim/jdtls-workspace/
```

## 📚 Crear un Proyecto Spring Boot

### Opción 1: Spring Initializr (Web)
1. Ve a https://start.spring.io/
2. Configura tu proyecto
3. Descarga y descomprime
4. Abre con Neovim: `nvim nombre-proyecto/`

### Opción 2: Spring CLI
```bash
# Instala Spring CLI
sdk install springboot

# Crea proyecto
spring init --dependencies=web,data-jpa,lombok --build=maven mi-proyecto
cd mi-proyecto
nvim .
```

### Opción 3: Maven Archetype
```bash
mvn archetype:generate \
  -DgroupId=com.ejemplo \
  -DartifactId=mi-proyecto \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false

cd mi-proyecto
nvim .
```

## 🎯 Ejemplo de Uso

1. Abre un proyecto Spring Boot:
```bash
cd tu-proyecto-spring
nvim .
```

2. Crea una entidad:
```java
// Escribe: entity + Tab
@Entity
@Table(name = "usuarios")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String nombre;
    private String email;
}
```

3. Crea un repositorio:
```java
// Escribe: repository + Tab
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    // El LSP te sugerirá métodos automáticamente
}
```

4. Crea un servicio:
```java
// Escribe: service + Tab
@Service
public class UsuarioService {
    // Escribe: autowired + Tab
    @Autowired
    private UsuarioRepository repository;
}
```

5. Crea un controlador:
```java
// Escribe: controller + Tab
@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {
    
    @Autowired
    private UsuarioService service;
    
    // Escribe: getmapping + Tab
    @GetMapping
    public ResponseEntity<List<Usuario>> listar() {
        return ResponseEntity.ok(service.listarTodos());
    }
}
```

## 🔄 Actualizar Herramientas

```vim
:Mason
```
Presiona `U` para actualizar todos los paquetes.

## 📖 Recursos Adicionales

- [jdtls Documentation](https://github.com/eclipse/eclipse.jdt.ls)
- [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [Project Lombok](https://projectlombok.org/)

## ✨ Próximos Pasos

1. Explora los snippets disponibles
2. Personaliza los atajos de teclado en `java-lsp.lua`
3. Configura tu JDK específico si usas múltiples versiones
4. Añade más snippets personalizados en `luasnip.lua`

¡Disfruta programando en Java con Neovim! 🚀
