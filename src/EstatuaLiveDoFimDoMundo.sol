// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EstatuaLiveDoFimDoMundo is ERC721, ERC721URIStorage, Ownable {

    string public storedBaseUrl;
    bool public isMetadataStoredInIPFS = false;

    constructor() ERC721("Estatua Live do Fim do Mundo", "ELFM") {
        _mint(msg.sender, 1);
        storedBaseUrl = "https://jeffprestes.github.io/livedofimdomundo/nft/metadata/";
    }

    function _baseURI() internal view override returns (string memory) {
        return storedBaseUrl;
    }

    function changeBaseURI(string memory _newBaseURI, bool _isMetadataStoredInIPFS) external onlyOwner returns (bool) {
        storedBaseUrl = _newBaseURI;
        isMetadataStoredInIPFS = _isMetadataStoredInIPFS;
        return true;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        if (isMetadataStoredInIPFS) {
            return storedBaseUrl;
        }
        return string(bytes.concat(bytes(super.tokenURI(tokenId)), bytes(".json")));
    }
}
