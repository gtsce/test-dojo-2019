describe "WebTeste" do

    context 'nao logado' do
        it "login" do
            visit "https://seubarriga.wcaquino.me/login"
            fill_in 'email', with: 'gtsce@gts.com'
            fill_in 'senha', with: 'gtscearrochado'
            click_button 'Entrar'
            expect(page).to have_content 'Bem vindo, GTS-CE Arrochado!'
        end
        
        it "login errado" do
            visit "https://seubarriga.wcaquino.me/login"
            fill_in 'email', with: 'gtsce@gts.com'
            fill_in 'senha', with: 'gts'
            click_button 'Entrar'
            expect(page).to have_content 'Problemas com o login do usuário'
        end
            
        it "criar novo usuario com sucesso" do
            visit "https://seubarriga.wcaquino.me/cadastro"
            fill_in 'nome', with: 'Jefferson'
            fill_in 'email', with: Faker::Internet.email
            fill_in 'senha', with: 'npixp@'
            click_button 'Cadastrar'
            expect(page).to have_content 'Usuário inserido com sucesso'
        end
            
        it "criar novo usuario com email já utilizado" do
            visit "https://seubarriga.wcaquino.me/cadastro"
            fill_in 'nome', with: 'Jefferson'
            fill_in 'email', with: 'jefferson.mello8@hotmail.com'
            fill_in 'senha', with: 'npixp@'
            click_button 'Cadastrar'
            expect(page).to have_content 'Endereço de email já utilizado'
        end
    end

    context 'autenticado' do
        before(:each) do
            visit "https://seubarriga.wcaquino.me/login"
            fill_in 'email', with: 'gtsce@gts.com'
            fill_in 'senha', with: 'gtscearrochado'
            click_button 'Entrar'
        end 
        it "accountAdd sem movimentação" do
            5.times do
                visit "https://seubarriga.wcaquino.me/addConta"
                fill_in 'nome', with: Faker::Name.name
                click_button 'Salvar' 
            end
        end
        it "movimentacaoAdd" do
            visit "https://seubarriga.wcaquino.me/movimentacao"
            fill_in 'data_transacao', with: "11/12/2019"
            fill_in 'data_pagamento', with: "20/12/2019"
            fill_in 'descricao', with: "test"
            fill_in 'interessado', with: "Rebeca"
            fill_in 'valor', with: "100"
            click_button 'Salvar'
            expect(page).to have_content "Movimentação adicionada com sucesso!"
        end
        let(:name) {Faker::Name.name}
        it "deleteAcc sem movimentação", :teste do
            visit "https://seubarriga.wcaquino.me/addConta"
            fill_in 'nome', with: name
            click_button 'Salvar'

            visit "https://seubarriga.wcaquino.me/contas"
            
            find_all('tr').each do |tr|
                if tr.find('td[0]').text == name
                    tr.find('.glyphicon.glyphicon-remove-circle').click
                    sleep 5
                    break
                end
            end 
            expect(page).to have_content 'Conta removida com sucesso!'
        end

        it "deleteAcc sem movimentação", :teste do
            visit "https://seubarriga.wcaquino.me/contas"
            find(:xpath, '//*[@id="tabelaContas"]/tbody/tr[3]/td[2]/a[2]/span').click
            expect(page).to have_content 'Conta removida com sucesso!'
        end
    end
end
