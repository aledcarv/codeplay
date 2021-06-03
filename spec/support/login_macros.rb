module LoginMacros
    def user_login
        user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
        login_as user, scope: :user
    end
end