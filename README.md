# Sistema Especialista de Recomendação de Trilhas em Tecnologia

- Instituição: [PUCPR](https://www.pucpr.br/)
- Curso: Ciência da Computação
- Disciplina:Programação Lógica e Funcional
- Professor(a): Frank Coelho de Alcantra
- Aluno (a): [Larissa Alves da Silva](https://github.com/larissa04alves)

## 🎯 Objetivo

Sistema em Prolog que entrevista o estudante (perguntas de “sim”/“não”), infere pontuações por trilhas e fornece um ranking com justificativas.

**O que este projeto entrega:**

- Questionário dinâmico interativo.
- Armazenamento dinâmico das respostas
- Cálculo de compatibilidade por trilha (base de fatos + regras).
- Resultado ranqueado com explicações.
- Execução interativa e modo de teste.

# 📁 Estrutura do repositório

```
.
├─ sistema.pl                 # Código principal (módulo sistema)
├─ testes/
│  ├─ teste-perfil-ia.pl     # Perfil exemplo: inclinação para IA
│  ├─ teste-perfil-dados.pl  # Perfil exemplo: inclinação para Dados
│  └─ teste-perfil-redeSec.pl    # Perfil exemplo: inclinação para redes e segurança
│  └─ teste-perfil-web.pl    # Perfil exemplo: inclinação para desenvolvimento web
└─ README.md
```

## 🧰 Requisitos

- SWI-Prolog 8.x ou superior

- (Opcional) VSCode + extensão SWI-Prolog

### ▶️ Como executar no Terminal (Ubuntu ou VSCode)

Você pode validar automaticamente perfis com os **arquivos de teste**:

```
swipl
?- [sistema].
?- sistema:testar('testes/teste-perfil-ia.pl').
?- sistema:testar('testes/teste-perfil-dados.pl').
?- sistema:testar('testes/teste-perfil-web.pl').
```

Ou de **forma interativa**

```
swipl
?- [sistema].
?- sistema:iniciar.
```

### ☁️ Como executar online no SWISH

- Acesse o site do [SWISH](https://swish.swi-prolog.org/).
- Cole o conteúdo de sistema.pl em um notebook SWISH.
- Para o modo interativo, chame:

**Simular respostas** no próprio SWISH

```
?- resposta(1, s). resposta(2, n). resposta(3, s). ...
```

Utilizar no modo **interativo**

```
?- iniciar.
```

## 📜 Observações finais

Este projeto tem fins estritamente acadêmicos e foi desenvolvido para a disciplina informada. Não é destinado a uso comercial. Resultados e recomendações são ilustrativos e dependem das respostas fornecidas pelo usuário.
