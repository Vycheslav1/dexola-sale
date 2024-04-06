// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol";
import "../contracts/Tokensale.sol";

contract TokensaleTest is Tokensale{

    function testTokenInitialValues() public {
        Assert.equal(name(), "Token Sale", "token name did not match");
        Assert.equal(symbol(), "TKS", "token symbol did not match");
        Assert.equal(decimals(), 18, "token decimals did not match");
        Assert.equal(totalSupply(), 0, "token supply should be zero");
    }
}