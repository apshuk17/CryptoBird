import { useWeb3 } from "@components/providers";

const Navbar = () => {
  const { accountConnected = null } = useWeb3();
  return (
    <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap px-4 shadow">
      <div className="navbar-brand col-sm-3 mr-0">
        Krypto Birdz NFTs (Non Fungible Tokens)
      </div>
      {accountConnected ? (
        <ul className="navbar-nav">
          <li className="nav-item text-nowrap d-none d-sm-none d-md-block">
            <small className="text-white">{accountConnected}</small>
          </li>
        </ul>
      ) : null}
    </nav>
  );
};

export default Navbar;
