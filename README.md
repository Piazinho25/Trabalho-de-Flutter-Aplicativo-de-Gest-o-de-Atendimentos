# 📱 My Service – Aplicativo de Gestão de Atendimentos  
Aplicativo Flutter desenvolvido para facilitar o gerenciamento de atendimentos, permitindo criação, execução, finalização e armazenamento local das informações.

---

## 📌 Sobre o Projeto

O **My Service** foi criado para auxiliar técnicos e profissionais que precisam registrar atendimentos de forma rápida, simples e organizada.  

Com ele é possível:

- Criar atendimentos com foto e descrição  
- Listar atendimentos ativos e finalizados  
- Atualizar atendimentos em andamento  
- Finalizar atendimentos com foto final e observações  
- Visualizar detalhes de atendimentos finalizados em um modal  
- Armazenar tudo localmente usando SQLite  

O sistema funciona **offline**, sendo ideal para trabalhos externos.

---

## 🛠️ Tecnologias e Dependências

O projeto utiliza diversas bibliotecas para garantir modularidade, organização e funcionalidades avançadas.

### 📦 **Dependências Utilizadas**

| Dependência               | Função |
|---------------------------|--------|
| **sqflite**               | Banco de dados local SQLite para salvar atendimentos, fotos e descrições. |
| **image_picker**          | Captura de imagens da câmera ou galeria. |
| **get_it**                | Service Locator para gerenciamento de instâncias. |
| **injectable**            | Configuração automatizada de injeção de dependência. |
| **build_runner**          | Executor de geradores de código, necessário para o injectable. |
| **injectable_generator**  | Gera automaticamente código para DI, eliminando escrita manual. |

---

## 📂 Estrutura do Projeto

lib/
├ main.dart
└ module/
└ atendimento/
├ controller/
│ atendimento_controller.dart
├ pages/
│ atendimento_form_page.dart
│ dashboard_page.dart
│ execucao_page.dart
└ util/
database.dart

yaml
Copiar código

Estrutura simples, organizada e fácil de manter.

---

## ✨ Funcionalidades

### 🟦 **Dashboard**
- Lista todos os atendimentos
- Mostra imagem, título, status e última descrição
- Botões de **editar** e **excluir**
- Clique em atendimento ativo → abre página de execução  
- Clique em atendimento finalizado → abre modal pull-up com detalhes

---

### 🟩 **Criar Atendimento**
- Formulário com título e descrição  
- Upload de foto pela câmera  
- Salvo no SQLite  
- Status inicial: `ativo`

---

### 🟧 **Executar Atendimento**
- Adiciona foto final  
- Campo para observações  
- Alteração do status para `finalizado`  
- Após finalizado, edição é bloqueada

---

### 🟪 **Visualização de Atendimentos Finalizados**
- Mostra foto final  
- Última observação  
- Status e data  
- Layout em estilo bottom sheet (pull up)

---

## 💾 Banco de Dados (SQLite)

Estrutura da tabela:

id INTEGER PRIMARY KEY
titulo TEXT
descricao TEXT
imagePath TEXT
status TEXT
createdAt TEXT

yaml
Copiar código

Operações implementadas:

- Criar atendimento  
- Atualizar  
- Finalizar  
- Excluir  
- Listar todos  

---

## ▶️ Como Rodar o Projeto

### 1. Baixar dependências:
```sh
flutter pub get
Rodar no emulador ou dispositivo:
flutter run

👨‍💻 Autor

Projeto desenvolvido por Victor Tasca Decesare
Para fins acadêmicos e portfólio profissional.

📄 Licença

Este projeto é de uso livre para estudo e evolução.
Modificações são permitidas desde que os créditos sejam mantidos.


---

# 🎉 READY!  
Se quiser:

🔹 adicionar imagens das telas  
🔹 adicionar badges (Flutter, Dart, Sqflite…)  
🔹 criar versão em inglês  
🔹 deixar mais minimalista

é so chamar.
