import UIKit

struct Doce {
    
}

struct Vovozinha {
    var doces:[Doce] = []
}

enum ProblemasCaminho: Error {
    case loboMauPasseiaAquiPorPerto
}


struct ChapeuzinhoVermelho {
    
    var loboNoCaminho:Bool = false
    
    
    
    func pelaEstradaAForaEuVouBemSozinha() throws -> [Doce] {
        if (loboNoCaminho) {
            throw ProblemasCaminho.loboMauPasseiaAquiPorPerto
        }
        
        return []
    }
    
}

func historia() {
    
    func tchauLobo() {
        
    }
    
    func viveramFelizesParaSempre() {
        
    }
    
    let chapeuzinhoVermelho = ChapeuzinhoVermelho()
    var vovozinha = Vovozinha()
    do {
        vovozinha.doces = try chapeuzinhoVermelho.pelaEstradaAForaEuVouBemSozinha()
    } catch {
        tchauLobo()
        viveramFelizesParaSempre()
    }
    
}
