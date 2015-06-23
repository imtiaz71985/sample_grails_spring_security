package sample

import actions.secuser.CreateSecUserActionService
import actions.secuser.DeleteSecUserActionService
import actions.secuser.ListSecUserActionService
import actions.secuser.UpdateSecUserActionService

class SecUserController extends BaseController {

    static allowedMethods = [
            show: "POST", create: "POST", update: "POST",delete: "POST", list: "POST"
    ]

    CreateSecUserActionService createSecUserActionService
    UpdateSecUserActionService updateSecUserActionService
    DeleteSecUserActionService deleteSecUserActionService
    ListSecUserActionService listSecUserActionService

    def show() {
        render(view: "/secUser/show")
    }
    def create() {
        renderOutput(createSecUserActionService, params)

    }
    def update() {
        renderOutput(updateSecUserActionService, params)

    }
    def delete() {
        renderOutput(deleteSecUserActionService, params)

    }
    def list() {
         renderOutput(listSecUserActionService, params)
    }
}
