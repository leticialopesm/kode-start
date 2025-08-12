# 📱 Rick and Morty App – Desafio Kode Start 📱

Aplicativo Flutter que consome a **Rick and Morty API** para exibir informações detalhadas sobre personagens da série, atendendo aos requisitos do desafio **Kode Start** by Kobe.

---

## Funcionalidades Implementadas

###  Funcionalidades obrigatórias
- **Lista de personagens** com rolagem infinita (scroll infinito/paginação).
- **Cards** exibindo **nome** e **imagem**.
- **Tela de detalhes** com:
  - Nome
  - Imagem
  - Espécie
  - Gênero
  - Status
  - Origem
  - Última localização
  - Primeira aparição (episódio)
- **Navegação** da listagem para o detalhe.

###  Funcionalidades opcionais e extras
- **Busca por nome** (parcial ou completa).
- **Tradução PT-BR** de todos os campos e nomes de episódios, com dicionário customizado.
- **Hero Animation** entre a imagem do card e a imagem de detalhe, para transições mais suaves.
- **Design responsivo**, compatível com **Android** e **iOS**.

---

##  Tecnologias Utilizadas
- **[Flutter](https://flutter.dev/)** (Dart)
- **[Provider](https://pub.dev/packages/provider)** – Gerenciamento de estado
- **[Dio](https://pub.dev/packages/dio)** – Requisições HTTP
- **[Google Fonts](https://pub.dev/packages/google_fonts)** – Tipografia
- **Material 3** – Estilização
- **Hero Animation** – Animação de transição de imagens

---

##  Estrutura de Pastas
```plaintext
lib/
├── data/
│   ├── models/         # Modelos de dados (Character)
│   └── services/       # Comunicação com a API (ApiService)
├── presentation/
│   ├── pages/          # Telas (lista e detalhe)
│   ├── providers/      # Providers (estado)
│   └── widgets/        # Componentes (cards, etc.)
├── main.dart           # Ponto de entrada
assets/
└── images/             # Ícones e imagens do layout
```

# Como Rodar o Projeto


## Pré-requisitos
___

-> Flutter SDK instalado - Guia Oficial -> (https://docs.flutter.dev/get-started/install)

-> Dispositivo ou emulador configurado (Android/iOS)

-> Ter o repositório clonado

---

# Passos para execução

## Clone o projeto
git clone https://github.com/<seu-usuario>/kode-start.git

## Acesse a pasta do projeto
cd kode-start/app

## Instale as dependências
flutter pub get

## Rode o app
flutter run

---

# Contato

📧 Email: leticialopesdm@gmail.com
🔗 LinkedIn: www.linkedin.com/in/leticia-lopes-a81314269




