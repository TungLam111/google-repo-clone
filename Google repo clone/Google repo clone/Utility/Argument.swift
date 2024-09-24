import Foundation

class AuthenticationArgs {
    
}

class DishDetailArgs {
    var id: String; // mealId
    var basketId: String?;
    
    init(id: String, basketId: String?) {
        self.id = id
        self.basketId = basketId
    }
}

class CouponArgs {
    var onSelect: (String) -> Void;
    
    init(onSelect: @escaping (String) -> Void) {
        self.onSelect = onSelect
    }
}
