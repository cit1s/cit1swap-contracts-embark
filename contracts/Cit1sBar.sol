// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12;

import "./libraries/ERC20.sol";
import "./libraries/Ownable.sol";
import './libraries/SafeMath.sol';
import "./libraries/Address.sol";
//Deposit Token name = Cit1s
//Staking Token name = xCit1s

contract Cit1sBar is ERC20("Cit1sBar", "xCit1s"){
    using SafeMath for uint256;
    IERC20 public cit1s;

    constructor(IERC20 _cit1s) public{
        cit1s = _cit1s;
    }

    // Enter the bar. Pay some CIT1Ss. Earn some shares.
    function enter(uint256 _amount) public {
        uint256 totalCit1s = cit1s.balanceOf(address(this));
        uint256 totalShares = totalSupply();
        if (totalShares == 0 || totalCit1s == 0) {
            _mint(msg.sender, _amount);
        } else {
            uint256 what = _amount.mul(totalShares).div(totalCit1s);
            _mint(msg.sender, what);
        }
        cit1s.transferFrom(msg.sender, address(this), _amount);
    }

    // Leave the bar. Claim back your CIT1Ss.
    function leave(uint256 _share) public {
        uint256 totalShares = totalSupply();
        uint256 what = _share.mul(cit1s.balanceOf(address(this))).div(totalShares);
        _burn(msg.sender, _share);
        cit1s.transfer(msg.sender, what);
    }
}