
// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12;

import "./libraries/ERC20.sol";
import "./libraries/Ownable.sol";
import './libraries/SafeMath.sol';

contract Cit1sToken is ERC20, Ownable {
    using SafeMath for uint256;

    //default Token's Decimal = 18
    constructor(string memory _name, string memory _symbol) ERC20 (_name,_symbol) public {
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        //minting token
        _mint(_to, _amount);
       
    }

     function burn(address _to, uint256 _amount) external onlyOwner {
        _burn(_to, _amount);
    }
 
}