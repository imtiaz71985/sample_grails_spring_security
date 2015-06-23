package service

import asia.grails.sample.SecUser
import sample.BaseService

class SecUserService extends BaseService{

    public SecUser read(long id) {
       return SecUser.read(id)
    }
    public int countByUsernameIlike(String username){
        return SecUser.countByUsernameIlike(username)
    }
}
