## Projeto de automação de testes de API REST

Automação de testes de API para criar, listar e deletar contatos.

**O projeto possui as seguintes Gems:**

- Cucumber (permite a escrita de testes em uma linguagem muito próxima da natural)
- Faker (usado para gerar dados falsos: nomes, endereços, números de telefone etc)
- Httparty (facilita o consumo de serviços rest)
- Rspec (framework BDD para ruby)

**O projeto possui as seguintes funcionalidades:**
- [x] Cenário de testes para criar e listar contatos válidos;
- [x] Cenário outline de testes para verificar a criação de contatos inválidos;
- [x] Cenário de testes para excluir contatos válidos e inválidos;
- [x] Verificação das mensagens de resposta;
- [x] Verificação do status code;
- [x] Possui relatório dos testes em formato html - Pasta reports;
- [x] Configurado para rodar no Jenkins;
- [x] Configurado para gerar relatório no Jenkins;
- [x] Cenários de testes descritos em Gherkin.


### Pré requisitos:

- Gerenciador de versões do Ruby;
- Ruby >= 2.6.1;
- Bundler.

**Dicas:**

*Guia de instalação do Gerenciador de versões do Ruby + Ruby + Bundler no Linux:*
- [Rbenv] - O Rbenv fornece suporte para trabalhar com versões do Ruby. Comandos linux para instalação:
	- git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	- echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	- echo 'eval "$(rbenv init -)"' >> ~/.bashrc
	- source ~/.bashrc
	- type rbenv
	- git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
- [Ruby] - Comandos linux para instalação:
	- rbenv install -l
	- rbenv install 2.6.1
	- rbenv global 2.6.1
	Para verificar se deu tudo certo, digite o comando:
	- ruby -v
- [Bundler]
	- gem install bundler

*Guia de instalação do Ruby + Devkit + Bundler no Windows:*
- [Guia] - https://medium.com/qaninja/instalando-ruby-cucumber-e-capybara-no-windows-10-acb1fe833a95


### Executando os testes:

- 1- Na pasta do projeto execute o seguinte comando que irá instalar as Gems:
	- bundle install

- 2- Para rodar todos os testes utilizando o profile de Produção, execute o seguinte comando na pasta do projeto:
	- bundle exec cucumber -p prod

- Para rodar cenários específicos utilize tags:
	- bundle exec cucumber -p prod -t @criar
    - bundle exec cucumber -p prod -t @excluir


### Para rodar os testes no Jenkins:

**1-Criando JOB no Jenkins:**
- Criar um novo Job no Jenkins do tipo Pipeline;
- Nas configurações de "Pipeline Definition" selecionar "Pipeline script from SCM" e em "SCM" selecionar o "Git";
- Colocar a URL do projeto de testes no "Repository URL": https://github.com/bianamello/automacaoTestes-api-contatos.git

**2-Inserindo plugin Cucumber reports no Jenkins (O projeto está configurado no Jenkinsfile para gerar o relatório no Jenkins):**
- Clicar em Gerenciar Jenkins/ Gerenciar plugins
- Clicar em Disponíveis e filtrar por "cucumber reports"
- Selecionar e Baixar
- Após baixar, selecionar a opção para reiniciar o Jenkins

**3-Para rodar os testes no pipeline do Jenkins:**
- Clicar no Job criado
- Clicar em "Construir agora"

**4-Para visualizar o relatório de testes no Jenkins:**
- Clicar no Job criado
- Clicar em "Cucumber reports" Obs.: Relatório fica disponível após rodar um teste "Construir agora"