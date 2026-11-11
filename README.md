# Robot Browser Lab

![Robot Framework Tests](https://github.com/RoxaneNayara/robot-browser-lab/actions/workflows/robot-tests.yml/badge.svg)

Projeto de estudo de automação de testes com **Robot Framework**, cobrindo duas frentes:

- **Web (frontend):** login no [Sauce Demo](https://www.saucedemo.com) com a **Browser Library** (que usa o Playwright por baixo)
- **API (backend):** cadastro de usuários e login na [ServeRest](https://serverest.dev) com a **RequestsLibrary**

## Stack

Robot Framework · Browser Library (Playwright) · RequestsLibrary · Python · GitHub Actions

## Arquitetura

```
tests/
├── web/login.robot          → cenários web com palavras-chave
├── web/login_bdd.robot      → cenários web em BDD (Dado/Quando/Então)
└── api/usuarios.robot       → cenários de API
resources/
├── base.resource            → configuração do navegador
├── data/                    → massa de dados
├── pages/                   → Page Objects (seletores e ações)
├── steps/                   → passos BDD em linguagem de negócio
└── api/                     → Service Object da API
```

## Cenários cobertos

| Frente | Cenário | Tipo |
|---|---|---|
| Web | Login com usuário válido | positivo |
| Web | Login com senha inválida | negativo |
| Web | Login com usuário bloqueado | negativo |
| API | Cadastro de usuário com sucesso | positivo |
| API | Bloqueio de cadastro com email duplicado | negativo |
| API | Login com sucesso retorna token Bearer | positivo |
| API | Login com senha inválida retorna 401 | negativo |

Os cenários web existem em dois estilos: palavras-chave diretas e **BDD em português**.

## Boas práticas aplicadas

- **Page Object e Service Object:** seletores, ações e chamadas de API ficam em um só lugar
- **BDD em português:** cenários legíveis para Produto e negócio, executados nativamente pelo Robot
- **Massa de dados dinâmica:** cada teste de API gera um usuário único e o exclui no teardown, sem sujar o ambiente
- **Tags** para execução seletiva (`smoke`, `negativo`, `bdd`, `api`)
- **CI com GitHub Actions** a cada push e PR, com relatórios publicados mesmo em caso de falha
- **Pipeline com gates progressivos:** lint com Robocop → smoke → regressão. Se um estágio falha, os seguintes não rodam
- **Lint com Robocop:** código de teste padronizado, com regras desligadas apenas por decisão documentada (`robocop.toml`)

## Como executar

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
rfbrowser init

robot -d results tests                       # todos os testes
robot -d results -i smoke tests              # apenas smoke
robot -d results -v HEADLESS:True tests      # sem abrir o navegador
```

Os relatórios ficam em `results/report.html` e `results/log.html`.

## Autora

**Roxane Nayara**: [LinkedIn](https://www.linkedin.com/in/roxane-nayara/) · [Portfólio](https://roxanenayara.github.io/)
