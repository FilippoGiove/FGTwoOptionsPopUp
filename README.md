# FGTwoOptionsPopUp (iOS)
Custom popup with two possible choices. It handle its position respect an "anchor view".


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Installing

Just copy all the swift classes in the Library Group in your project.

## Example

```
self.twoOptionPopUp = FGTwoOptionsPopUp(anchorView: self.twoOptionsButton)
self.twoOptionPopUp.getLeftButton().setTitle("LEFT", for: UIControlState())
self.twoOptionPopUp.getRightButton().setTitle("RIGHT", for: UIControlState())
self.twoOptionPopUp.getLeftButton().addTarget(self, action: #selector(self.openORClose_UP), for:.touchUpInside)
self.twoOptionPopUp.getRightButton().addTarget(self, action: #selector(self.openORClose_UP), for:.touchUpInside)
self.view.addSubview(self.twoOptionPopUp)
//IMPORTANT! Put this after adding popup to superview
self.twoOptionPopUp.addAllConstraints()```
```

## Authors

[Filippo Giove](https://github.com/FilippoGiove)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


