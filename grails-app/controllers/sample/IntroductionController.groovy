package sample

class IntroductionController {

    def aboutUs() {
        render(view: '/introduction/aboutUs')
    }

    def contact(){
        render(view: '/introduction/contact')
    }
}
