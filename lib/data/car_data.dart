import '../models/car.dart';

class CarData {
  static List<Car> getCars() {
    return [
      Car(
        id: '1',
        name: 'Toyota Camry',
        type: 'Sedan',
        imageUrl:
            'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400',
        pricePerDay: 500000,
      ),
      Car(
        id: '2',
        name: 'Honda CR-V',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400',
        pricePerDay: 650000,
      ),
      Car(
        id: '3',
        name: 'Toyota Avanza',
        type: 'MPV',
        imageUrl:
            'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
        pricePerDay: 400000,
      ),
      Car(
        id: '4',
        name: 'Mitsubishi Pajero',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400',
        pricePerDay: 800000,
      ),
      Car(
        id: '5',
        name: 'Honda Jazz',
        type: 'Hatchback',
        imageUrl:
            'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=400',
        pricePerDay: 350000,
      ),
      Car(
        id: '6',
        name: 'Toyota Fortuner',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=400',
        pricePerDay: 750000,
      ),
    ];
  }
}
