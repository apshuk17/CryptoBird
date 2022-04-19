import { useState, useEffect } from "react";

const useKryptoBirdz = ({ contract }) => {
  const [kryptoSupply, setKryptoSupply] = useState({
    totalSupply: null,
    kryptoBirdz: null,
    kryptoBirdzCount: null
  });

  useEffect(() => {
    const getTotalSupply = async () => {
      if (contract) {
        const totalSupply = await contract.methods.totalSupply().call();
        const kryptoBirdzCount = await contract.methods
          .getKrytoBirdzCount()
          .call();
        const kryptoBirdz = await contract.methods.getKrytoBirdz().call();
        setKryptoSupply({
            totalSupply,
            kryptoBirdz,
            kryptoBirdzCount
        })
      }
    };
    getTotalSupply();
  }, [contract]);

  return kryptoSupply;
};

export default useKryptoBirdz;
