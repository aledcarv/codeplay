require 'rails_helper'

describe 'account management' do
    context 'registration' do
        it 'with email and password' do
            visit root_path
            click_on 'Registrar-me'
    
            fill_in 'Email', with: 'pessoa.cadastro@code.com'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '012345'
            click_on 'Criar conta'
    
            expect(current_path).to eq(root_path)
            expect(page).to have_text('Login efetuado com sucesso')
            expect(page).to have_text('pessoa.cadastro@code.com')
            expect(page).to_not have_text('Registrar-me')
            expect(page).to have_text('Sair')
        end        

        it 'without valid field' do
            visit root_path
            click_on 'Registrar-me'
            click_on 'Criar conta'

            expect(page).to have_content('não pode ficar em branco', count: 2)
        end

        it 'and email already being used' do
            User.create!(email: 'pessoa.cadastro@code.com', password: '012345')

            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: 'pessoa.cadastro@code.com'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '012345'
            click_on 'Criar conta'

            expect(page).to have_content('já está em uso')
        end

        it 'password does not match confirmation' do
            visit root_path
            click_on 'Registrar-me'
            
            fill_in 'Email', with: 'pessoa.cadastro@code.com'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '123456'
            click_on 'Criar conta'

            expect(page).to have_text('não é igual a Senha')
        end
    end

    context 'sign in' do
        it 'with email and password' do
            User.create!(email: 'pessoa.cadastro@code.com', password: '012345')

            visit root_path
            click_on 'Entrar'

            fill_in 'Email', with: 'pessoa.cadastro@code.com'
            fill_in 'Senha', with: '012345'
            within 'form' do
                click_on 'Entrar'
            end

            expect(current_path).to eq(root_path)
            expect(page).to have_text('Login efetuado com sucesso')
            expect(page).to have_text('pessoa.cadastro@code.com')
            expect(page).to have_text('Sair')
            expect(page).to_not have_text('Registrar-me')
            expect(page).to_not have_text('Entrar')
        end
    end

    context 'log out' do
        it 'successfully' do
            user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')

            login_as user, scope: :user
            visit root_path
            click_on 'Sair'

            expect(current_path).to eq(root_path)
            expect(page).to have_text('Saiu com sucesso')
            expect(page).to_not have_text('pessoa.cadastro@code.com')
            expect(page).to_not have_text('Sair')
            expect(page).to have_text('Registrar-me')
            expect(page).to have_text('Entrar')
        end
    end
end