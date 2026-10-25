### Config

Configuration is optional in Obelisk 2. Public files under common/ and frontend/ are bundled with the production server.

Things that should never be transmitted to the frontend belong in backend/ (e.g., email credentials). Supply these at runtime; they are not bundled in the Nix store.

Frontend-only configuration belongs in frontend/.

Shared configuration files belong in common/. Obelisk 2 does not automatically read common/route; read it explicitly if the application needs an absolute base URL.
