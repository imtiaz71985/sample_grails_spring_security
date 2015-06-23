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

    public int countByUsernameIlikeAndIdNotEqual(String username, long id){
        return SecUser.countByUsernameIlikeAndIdNotEqual(username, id)
    }
}
