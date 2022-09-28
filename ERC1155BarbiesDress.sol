//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract ERC1155BarbiesDress is ERC1155 {
    uint256 public constant gown = 1;
    uint256 public constant jumpsuit = 2;
    uint256 public constant kaaftan = 3;
    constructor() ERC1155("https://ipfs.io/ipfs/bafybeiaosv6dz332ugm2uk75mlwpbct7uwyvtb72lb7cu2chfcgh5c5nru/{id}.json") {
        _mint(msg.sender, gown, 100, "");
        _mint(msg.sender, jumpsuit, 100, "");
        _mint(msg.sender, kaaftan, 100, "");
    }
      function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/bafybeiaosv6dz332ugm2uk75mlwpbct7uwyvtb72lb7cu2chfcgh5c5nru/",
                Strings.toString(_tokenid),".json"
            )
        );
      }
}
