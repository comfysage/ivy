# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bqf = {
    pname = "bqf";
    version = "ebb6d2689e4427452180f17c53f29f7e460236f1";
    src = fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "nvim-bqf";
      rev = "ebb6d2689e4427452180f17c53f29f7e460236f1";
      fetchSubmodules = false;
      sha256 = "sha256-JhVi208hCsenyYy5XIyjeyeAopgw8cHzBm1w2QH+tf4=";
    };
    date = "2025-01-04";
  };
  bufferline = {
    pname = "bufferline";
    version = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "bufferline.nvim";
      rev = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3";
      fetchSubmodules = false;
      sha256 = "sha256-ae4MB6+6v3awvfSUWlau9ASJ147ZpwuX1fvJdfMwo1Q=";
    };
    date = "2025-01-14";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "f67b886d65a029f12ffa298701fb8f1efd89295d";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "f67b886d65a029f12ffa298701fb8f1efd89295d";
      fetchSubmodules = false;
      sha256 = "sha256-lwQLmqm01FihJdad4QRMK23MTrouyOokyuX/3enWjzs=";
    };
    as = "catppuccin";
    date = "2024-12-27";
  };
  cloak = {
    pname = "cloak";
    version = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
    src = fetchFromGitHub {
      owner = "laytan";
      repo = "cloak.nvim";
      rev = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
      fetchSubmodules = false;
      sha256 = "sha256-V7oNIu7IBAHqSrgCNoePNUPjQDU9cFThFf7XGIth0sk=";
    };
    date = "2024-06-12";
  };
  copilot-lua = {
    pname = "copilot-lua";
    version = "886ee73b6d464b2b3e3e6a7ff55ce87feac423a9";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "886ee73b6d464b2b3e3e6a7ff55ce87feac423a9";
      fetchSubmodules = false;
      sha256 = "sha256-c2UE0dLBtoYMvMxg+jXzfsD+wN9sZLvftJq4gGmooZU=";
    };
    date = "2024-12-22";
  };
  crates = {
    pname = "crates";
    version = "bd35b13e94a292ee6e32c351e05ca2202dc9f070";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "bd35b13e94a292ee6e32c351e05ca2202dc9f070";
      fetchSubmodules = false;
      sha256 = "sha256-dj7VXlMbS4HvSc+/WMQprtqWzrYrWaCnSEE0ygp/LcI=";
    };
    date = "2025-01-03";
  };
  direnv = {
    pname = "direnv";
    version = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
    src = fetchFromGitHub {
      owner = "NotAShelf";
      repo = "direnv.nvim";
      rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
      fetchSubmodules = false;
      sha256 = "sha256-nWdAIchqGsWiF0cQ7NwePRa1fpugE8duZKqdBaisrAc=";
    };
    date = "2024-07-08";
  };
  evergarden = {
    pname = "evergarden";
    version = "31f39772562b1c03a970f057cd5cbb8cff1e68fc";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "evergarden";
      rev = "31f39772562b1c03a970f057cd5cbb8cff1e68fc";
      fetchSubmodules = false;
      sha256 = "sha256-4JfdunwFNpWkCnCIG6kZRybBqNbPTJrlPvk/RQgJedM=";
    };
    date = "2025-01-14";
  };
  fidget = {
    pname = "fidget";
    version = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
    src = fetchFromGitHub {
      owner = "j-hui";
      repo = "fidget.nvim";
      rev = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
      fetchSubmodules = false;
      sha256 = "sha256-8Gl2Ck4YJGReSEq1Xeh1dpdRq4eImmrxvIHrfxdem3Q=";
    };
    date = "2023-11-09";
  };
  freeze = {
    pname = "freeze";
    version = "65c6e693a1d8ebd816bd3076350efa8e080c1c4a";
    src = fetchFromGitHub {
      owner = "charm-community";
      repo = "freeze.nvim";
      rev = "65c6e693a1d8ebd816bd3076350efa8e080c1c4a";
      fetchSubmodules = false;
      sha256 = "sha256-m8lsdVTbesC4IlohFFgkVeW3StqIfztfJ3/KAUgLzrI=";
    };
    date = "2024-12-28";
  };
  fzf-lua = {
    pname = "fzf-lua";
    version = "6f7249741168c0751356e3b6c5c1e3bade833b6b";
    src = fetchFromGitHub {
      owner = "ibhagwan";
      repo = "fzf-lua";
      rev = "6f7249741168c0751356e3b6c5c1e3bade833b6b";
      fetchSubmodules = false;
      sha256 = "sha256-rueyL7UJ+QBehsExZEWlN4y2wBEU1UGEyVewNyJh5bI=";
    };
    date = "2025-01-13";
  };
  go-nvim = {
    pname = "go-nvim";
    version = "c6d5ca26377d01c4de1f7bff1cd62c8b43baa6bc";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "go.nvim";
      rev = "c6d5ca26377d01c4de1f7bff1cd62c8b43baa6bc";
      fetchSubmodules = false;
      sha256 = "sha256-rv+4im9kh8VhbDbhoMLaUBD4pYKEfkUUPw/6R9EzqO8=";
    };
    date = "2024-12-01";
  };
  guihua-lua = {
    pname = "guihua-lua";
    version = "d783191eaa75215beae0c80319fcce5e6b3beeda";
    src = fetchFromGitHub {
      owner = "ray-x";
      repo = "guihua.lua";
      rev = "d783191eaa75215beae0c80319fcce5e6b3beeda";
      fetchSubmodules = false;
      sha256 = "sha256-XpUsbj1boDfbyE8C6SdOvZdkd97682VVC81fvQ5WA/4=";
    };
    date = "2024-11-02";
  };
  img-clip-nvim = {
    pname = "img-clip-nvim";
    version = "5ff183655ad98b5fc50c55c66540375bbd62438c";
    src = fetchFromGitHub {
      owner = "HakonHarnes";
      repo = "img-clip.nvim";
      rev = "5ff183655ad98b5fc50c55c66540375bbd62438c";
      fetchSubmodules = false;
      sha256 = "sha256-Q4v4E8Iay6rXvtUsM5ULo1cnBYduzTw42kIgJlodq5U=";
    };
    date = "2024-11-26";
  };
  indent-blankline = {
    pname = "indent-blankline";
    version = "7a698a1d7ed755af9f5a88733b23ca246ce2df28";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "7a698a1d7ed755af9f5a88733b23ca246ce2df28";
      fetchSubmodules = false;
      sha256 = "sha256-Y1WP3wDj2MFgqW1ssUro9enLZS+OM3XViv3j/4+5rrc=";
    };
    date = "2025-01-14";
  };
  keymaps-nvim = {
    pname = "keymaps-nvim";
    version = "62f10ae89dfcf065035c20ad3cda2c84f36e43ab";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "keymaps.nvim";
      rev = "62f10ae89dfcf065035c20ad3cda2c84f36e43ab";
      fetchSubmodules = false;
      sha256 = "sha256-Wgh9uVmKtKOCwo+Z3IFTp6Bv0m4QIju3FVPlxsHRWBg=";
    };
    date = "2024-03-12";
  };
  lazydev = {
    pname = "lazydev";
    version = "8620f82ee3f59ff2187647167b6b47387a13a018";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazydev.nvim";
      rev = "8620f82ee3f59ff2187647167b6b47387a13a018";
      fetchSubmodules = false;
      sha256 = "sha256-ZaAkGTwEBoOjy6RyIPKFLJswxfOu886bN899UakXAv0=";
    };
    date = "2024-12-20";
  };
  lsp-status = {
    pname = "lsp-status";
    version = "54f48eb5017632d81d0fd40112065f1d062d0629";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "lsp-status.nvim";
      rev = "54f48eb5017632d81d0fd40112065f1d062d0629";
      fetchSubmodules = false;
      sha256 = "sha256-gmLeVnDyL8Zf5ZG92tP3mb/LAt438BxFtAi/Xax2zLI=";
    };
    date = "2022-08-03";
  };
  lspkind = {
    pname = "lspkind";
    version = "d79a1c3299ad0ef94e255d045bed9fa26025dab6";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "d79a1c3299ad0ef94e255d045bed9fa26025dab6";
      fetchSubmodules = false;
      sha256 = "sha256-OCvKUBGuzwy8OWOL1x3Z3fo+0+GyBMI9TX41xSveqvE=";
    };
    date = "2024-12-05";
  };
  ltex-extra = {
    pname = "ltex-extra";
    version = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
    src = fetchFromGitHub {
      owner = "barreiroleo";
      repo = "ltex-extra.nvim";
      rev = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
      fetchSubmodules = false;
      sha256 = "sha256-OGeeEIF+z03DdJO2d2kzQ0lZnIYLabp6irYPqYgbCbc=";
    };
    date = "2024-06-15";
  };
  lualine = {
    pname = "lualine";
    version = "2a5bae925481f999263d6f5ed8361baef8df4f83";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "2a5bae925481f999263d6f5ed8361baef8df4f83";
      fetchSubmodules = false;
      sha256 = "sha256-IN6Qz3jGxUcylYiRTyd8j6me3pAoqJsJXtFUvph/6EI=";
    };
    date = "2024-11-08";
  };
  luasnip = {
    pname = "luasnip";
    version = "c9b9a22904c97d0eb69ccb9bab76037838326817";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "c9b9a22904c97d0eb69ccb9bab76037838326817";
      fetchSubmodules = false;
      sha256 = "sha256-3ecm5SDTcSOh256xSQPHhddQfMpepiEIpv58fHXrVg0=";
    };
    as = "luasnip";
    date = "2025-01-04";
  };
  lz-n = {
    pname = "lz-n";
    version = "224b99718cc17e0e7261211d8ea06fd630296973";
    src = fetchFromGitHub {
      owner = "nvim-neorocks";
      repo = "lz.n";
      rev = "224b99718cc17e0e7261211d8ea06fd630296973";
      fetchSubmodules = false;
      sha256 = "sha256-5UEyrAGslzDeqr95BcwAaOvI/4jbv96y9YV+GTxx77U=";
    };
    start = "true";
    date = "2025-01-12";
  };
  markview = {
    pname = "markview";
    version = "6e9f1840ba33e5318285ad97c22676f55b753479";
    src = fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "6e9f1840ba33e5318285ad97c22676f55b753479";
      fetchSubmodules = false;
      sha256 = "sha256-ZbZWF7hcJysfnbMraqsmK7PFSEU70P7TBKpZqgriTmk=";
    };
    date = "2025-01-08";
  };
  mini-ai = {
    pname = "mini-ai";
    version = "ebb04799794a7f94628153991e6334c3304961b8";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.ai";
      rev = "ebb04799794a7f94628153991e6334c3304961b8";
      fetchSubmodules = false;
      sha256 = "sha256-b/776l9nYM9e2atzXrvOk9dCxjzIuW/+iINC/yPv88Y=";
    };
    date = "2024-12-08";
  };
  mini-align = {
    pname = "mini-align";
    version = "e715137aece7d05734403d793b8b6b64486bc812";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.align";
      rev = "e715137aece7d05734403d793b8b6b64486bc812";
      fetchSubmodules = false;
      sha256 = "sha256-oHub8dEihIx4kcP3CD9GXG1SUObJUVpH4bg2Z6PmadQ=";
    };
    date = "2024-12-30";
  };
  mini-bracketed = {
    pname = "mini-bracketed";
    version = "1d1c774b5dcc9a55af3bfbd977571c31c4054223";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.bracketed";
      rev = "1d1c774b5dcc9a55af3bfbd977571c31c4054223";
      fetchSubmodules = false;
      sha256 = "sha256-ZCynEGv18hLGqjdh79ZFBEGkvqwjvzhTP9wuOYr9OBI=";
    };
    date = "2024-12-30";
  };
  mini-diff = {
    pname = "mini-diff";
    version = "00f072250061ef498f91ed226918c9ec31a416a4";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.diff";
      rev = "00f072250061ef498f91ed226918c9ec31a416a4";
      fetchSubmodules = false;
      sha256 = "sha256-dRvW/1lfVShiHmRU0mQA5g5xDyQ0EVtVLLZ0y6WSedg=";
    };
    date = "2024-12-27";
  };
  mini-files = {
    pname = "mini-files";
    version = "d0f03a5c38836fd2cce3dc80734124959002078c";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.files";
      rev = "d0f03a5c38836fd2cce3dc80734124959002078c";
      fetchSubmodules = false;
      sha256 = "sha256-UHW78m4BiYMMrABwdkyyzQUENgQrVFbWJnmNdRMtr0w=";
    };
    date = "2025-01-10";
  };
  mini-git = {
    pname = "mini-git";
    version = "fc13dde6cfe87cf25a4fd1ee177c0d157468436b";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini-git";
      rev = "fc13dde6cfe87cf25a4fd1ee177c0d157468436b";
      fetchSubmodules = false;
      sha256 = "sha256-rXuKopyZBCBbpKuytCdm8keruSNK1ohk2NdeZv1wifI=";
    };
    date = "2025-01-10";
  };
  mini-move = {
    pname = "mini-move";
    version = "4caa1c212f5ca3d1633d21cfb184808090ed74b1";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.move";
      rev = "4caa1c212f5ca3d1633d21cfb184808090ed74b1";
      fetchSubmodules = false;
      sha256 = "sha256-nX0eAlhMnKhAftgM6qeHUuawagumLQMPKDkqZNPLljg=";
    };
    date = "2024-08-15";
  };
  mini-pairs = {
    pname = "mini-pairs";
    version = "7e834c5937d95364cc1740e20d673afe2d034cdb";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.pairs";
      rev = "7e834c5937d95364cc1740e20d673afe2d034cdb";
      fetchSubmodules = false;
      sha256 = "sha256-PtHxLKU1smVTx655r5SINxuz5CJmZWnBW70T8zJ/oxM=";
    };
    date = "2024-10-11";
  };
  mini-splitjoin = {
    pname = "mini-splitjoin";
    version = "3e92f6764e770ba392325cad3a4497adcada695f";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.splitjoin";
      rev = "3e92f6764e770ba392325cad3a4497adcada695f";
      fetchSubmodules = false;
      sha256 = "sha256-LDIbh5KfupTI4zkYOlLmVCd3DuZRhx5lTASN53VG34g=";
    };
    date = "2024-07-01";
  };
  mini-surround = {
    pname = "mini-surround";
    version = "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.surround";
      rev = "aa5e245829dd12d8ff0c96ef11da28681d6049aa";
      fetchSubmodules = false;
      sha256 = "sha256-okWJlG0KOdg1ShvkIIMnPSoOzGd7K84eDcp5kx6eVP8=";
    };
    date = "2024-12-08";
  };
  mini-trailspace = {
    pname = "mini-trailspace";
    version = "3a328e62559c33014e422fb9ae97afc4208208b1";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.trailspace";
      rev = "3a328e62559c33014e422fb9ae97afc4208208b1";
      fetchSubmodules = false;
      sha256 = "sha256-JKYvFz8g8kVZvxE44RhwoHXQykghXx7ebW/Mj1ZdJIw=";
    };
    date = "2024-09-06";
  };
  neogen = {
    pname = "neogen";
    version = "dd0301bfba1f83a3bc009b5430fce7aa3cee6941";
    src = fetchFromGitHub {
      owner = "danymat";
      repo = "neogen";
      rev = "dd0301bfba1f83a3bc009b5430fce7aa3cee6941";
      fetchSubmodules = false;
      sha256 = "sha256-EzAbn9oDnzgi5ajNulzFz2thGoSlpr/if3xSpY57BG4=";
    };
    date = "2024-12-27";
  };
  none-ls = {
    pname = "none-ls";
    version = "3291afdff94e5083c7d6a4e9e661c3682c4b9b2a";
    src = fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "3291afdff94e5083c7d6a4e9e661c3682c4b9b2a";
      fetchSubmodules = false;
      sha256 = "sha256-5rOmjkxb7WD/AzvvJztPcDaQypmhtG+niC84vGx4vO8=";
    };
    date = "2025-01-14";
  };
  nvim-colorizer = {
    pname = "nvim-colorizer";
    version = "86c9a6a309b4812abf726c11ab3d9779415ce90b";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "86c9a6a309b4812abf726c11ab3d9779415ce90b";
      fetchSubmodules = false;
      sha256 = "sha256-QNuNHG2Kmiby9FQAeYYzGy1NZYmGaB5VN8Z7MS6XQHQ=";
    };
    date = "2025-01-14";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "339ccc81e08793c3af9b83882a6ebd90c9cc0d3b";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "339ccc81e08793c3af9b83882a6ebd90c9cc0d3b";
      fetchSubmodules = false;
      sha256 = "sha256-c5duLdwbK2xzzrnMkchmfOwR1iJ7tnHbbXNFl0vsqEY=";
    };
    date = "2025-01-14";
  };
  nvim-navic = {
    pname = "nvim-navic";
    version = "8649f694d3e76ee10c19255dece6411c29206a54";
    src = fetchFromGitHub {
      owner = "SmiteshP";
      repo = "nvim-navic";
      rev = "8649f694d3e76ee10c19255dece6411c29206a54";
      fetchSubmodules = false;
      sha256 = "sha256-0p5n/V8Jlj9XyxV/fuMwsbQ7oV5m9H2GqZZEA/njxCQ=";
    };
    date = "2023-11-30";
  };
  nvim-notify = {
    pname = "nvim-notify";
    version = "a3020c2cf4dfc4c4f390c4a21e84e35e46cf5d17";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "a3020c2cf4dfc4c4f390c4a21e84e35e46cf5d17";
      fetchSubmodules = false;
      sha256 = "sha256-C+HjESSYbDwWoDLGJqydV4eflH6327iAHbGyInKbgSA=";
    };
    date = "2025-01-09";
  };
  nvim-tree = {
    pname = "nvim-tree";
    version = "d529a99f88e0dff02e0aa275db2f595cd252a2c8";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "d529a99f88e0dff02e0aa275db2f595cd252a2c8";
      fetchSubmodules = false;
      sha256 = "sha256-33spbOlZaHYuFxY6DHSlg/RyMb1lC4TCM/KrpacUp0A=";
    };
    date = "2025-01-13";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "984214ef8e4ca18d77639663319aabdfba89632f";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "984214ef8e4ca18d77639663319aabdfba89632f";
      fetchSubmodules = false;
      sha256 = "sha256-wRdC+0V4oOrFgcqM8LW2j/Nm92d4d05OtlQ+cHavZII=";
    };
    date = "2025-01-14";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "aafa5c187a15701a7299a392b907ec15d9a7075f";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "aafa5c187a15701a7299a392b907ec15d9a7075f";
      fetchSubmodules = false;
      sha256 = "sha256-lUlEVEzXX8iCPxXIlpwkqBc19hks8qTvz4FdDNsTviI=";
    };
    date = "2025-01-10";
  };
  plenary = {
    pname = "plenary";
    version = "3707cdb1e43f5cea73afb6037e6494e7ce847a66";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "3707cdb1e43f5cea73afb6037e6494e7ce847a66";
      fetchSubmodules = false;
      sha256 = "sha256-18zX3kZ42ynRefFP0mOcy6ESEpejTukjNi4jCRXx48A=";
    };
    start = "true";
    date = "2025-01-12";
  };
  py_lsp = {
    pname = "py_lsp";
    version = "fe28db286c5cd3feb8e415d9f11cdaaf827e6c5a";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "fe28db286c5cd3feb8e415d9f11cdaaf827e6c5a";
      fetchSubmodules = false;
      sha256 = "sha256-4OH1dBDaiz+bK9oc7Z8qXvUcgARul0FoJQ3gQVT4aFM=";
    };
    date = "2024-11-17";
  };
  quill-nvim = {
    pname = "quill-nvim";
    version = "08103ea02643a93065fe7dbc4ed22275719fc338";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "quill.nvim";
      rev = "08103ea02643a93065fe7dbc4ed22275719fc338";
      fetchSubmodules = false;
      sha256 = "sha256-SDMoqQwY3cKj5c5wHFdE+G0ZWVIeLjF6DU67tfDfi8w=";
    };
    date = "2024-12-10";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "85b80abaa09cbbc039e3095b2f515b3cf8cadd11";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "85b80abaa09cbbc039e3095b2f515b3cf8cadd11";
      fetchSubmodules = false;
      sha256 = "sha256-zWHXYs3XdnoszqOFY3hA2L5mNn1a44OAeKv3lL3EMEw=";
    };
    date = "2025-01-12";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "ff10ab2bdcdbd55fdd9651d147a879bad7900647";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "ff10ab2bdcdbd55fdd9651d147a879bad7900647";
      fetchSubmodules = false;
      sha256 = "sha256-WHMX6I3C0fzzerYvWjrrGVg4w81IBi05BbpsGus8qzs=";
    };
    date = "2025-01-12";
  };
  sayama-nvim = {
    pname = "sayama-nvim";
    version = "39175a766dfc80324d3130d27c3e7922f826226e";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "sayama.nvim";
      rev = "39175a766dfc80324d3130d27c3e7922f826226e";
      fetchSubmodules = false;
      sha256 = "sha256-Rxjg6RvcN5JOP5CTv7Jj7AQJv36zRMaHiFEwhiBVgfw=";
    };
    date = "2024-05-30";
  };
  schemastore = {
    pname = "schemastore";
    version = "b16e414615f4dd7514f9df13dc9fa93e86d05a37";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "b16e414615f4dd7514f9df13dc9fa93e86d05a37";
      fetchSubmodules = false;
      sha256 = "sha256-d1Z9FWmvP6OSiX2eVdchCNs9H/p3Xp5EPgxwszZ+r5s=";
    };
    date = "2025-01-14";
  };
  shelf-nvim = {
    pname = "shelf-nvim";
    version = "c580fbffa2599ab6236486d35102c30598f60812";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "shelf.nvim";
      rev = "c580fbffa2599ab6236486d35102c30598f60812";
      fetchSubmodules = false;
      sha256 = "sha256-phO1/tOZ9Qq3M7no+G9PFPB+Gqf0eHSWnBw15SMEX3w=";
    };
    date = "2024-06-24";
  };
  snacks-nvim = {
    pname = "snacks-nvim";
    version = "541b46dfac694590a31448b7b764a2b7b16c7f09";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "541b46dfac694590a31448b7b764a2b7b16c7f09";
      fetchSubmodules = false;
      sha256 = "sha256-wTvsK4JPvmhegPXL5r+Zv62DWEVIIBYdsv4cb0PpYQo=";
    };
    date = "2025-01-14";
  };
  symbol-usage = {
    pname = "symbol-usage";
    version = "0f9b3da014b7e41559b643e7461fcabb2a7dc83a";
    src = fetchFromGitHub {
      owner = "Wansmer";
      repo = "symbol-usage.nvim";
      rev = "0f9b3da014b7e41559b643e7461fcabb2a7dc83a";
      fetchSubmodules = false;
      sha256 = "sha256-vNVrh8MV7KZoh2MtP+hAr6Uz20qMMMUcbua/W71lRn0=";
    };
    date = "2024-09-13";
  };
  todo-comments = {
    pname = "todo-comments";
    version = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5";
      fetchSubmodules = false;
      sha256 = "sha256-at9OSBtQqyiDdxKdNn2x6z4k8xrDD90sACKEK7uKNUM=";
    };
    date = "2025-01-14";
  };
  toggleterm = {
    pname = "toggleterm";
    version = "e76134e682c1a866e3dfcdaeb691eb7b01068668";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "e76134e682c1a866e3dfcdaeb691eb7b01068668";
      fetchSubmodules = false;
      sha256 = "sha256-4Y1TXxnrMLqwFlmbj39JTlcUToP80kWU+FpPUrYdz8s=";
    };
    date = "2024-12-30";
  };
  treewalker = {
    pname = "treewalker";
    version = "dc55ab606d21cb112dbf2a96546d1b46f6d63dfc";
    src = fetchFromGitHub {
      owner = "aaronik";
      repo = "treewalker.nvim";
      rev = "dc55ab606d21cb112dbf2a96546d1b46f6d63dfc";
      fetchSubmodules = false;
      sha256 = "sha256-Vi++8+OFpwevBpN9lTnk2JgOf0YfPNmZST4GO3YH32Q=";
    };
    date = "2025-01-13";
  };
  trouble = {
    pname = "trouble";
    version = "4d36b8979287f5facc03fd6d955ace67db667e1d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "4d36b8979287f5facc03fd6d955ace67db667e1d";
      fetchSubmodules = false;
      sha256 = "sha256-W7+12FrdUgPobARqlBbNmZ5epRJ/wtKoubx/FZi1QwY=";
    };
    date = "2025-01-13";
  };
  typescript-tools = {
    pname = "typescript-tools";
    version = "35e397ce467bedbbbb5bfcd0aa79727b59a08d4a";
    src = fetchFromGitHub {
      owner = "pmizio";
      repo = "typescript-tools.nvim";
      rev = "35e397ce467bedbbbb5bfcd0aa79727b59a08d4a";
      fetchSubmodules = false;
      sha256 = "sha256-x32NzZYFK6yovlvE3W8NevYA0UT0qvwKle1irFwmuvM=";
    };
    date = "2024-12-04";
  };
  undotree = {
    pname = "undotree";
    version = "2556c6800b210b2096b55b66e74b4cc1d9ebbe4f";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "2556c6800b210b2096b55b66e74b4cc1d9ebbe4f";
      fetchSubmodules = false;
      sha256 = "sha256-0DnRarEuDPdYo+zkwH47jG4B4fGjvL1LxqEoFQ7vpjE=";
    };
    date = "2025-01-01";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "174230d6a7f2df94705a7ffd8d5413e27ec10a80";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "174230d6a7f2df94705a7ffd8d5413e27ec10a80";
      fetchSubmodules = false;
      sha256 = "sha256-45zsqKavWoclA67MC54bAel1nE8CLHtSdullHByiRS8=";
    };
    date = "2024-12-29";
  };
  wakatime = {
    pname = "wakatime";
    version = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
    src = fetchFromGitHub {
      owner = "wakatime";
      repo = "vim-wakatime";
      rev = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
      fetchSubmodules = false;
      sha256 = "sha256-HxLmX+qws8A6+mFBGMdru2E3NXJ91P0HtDKMX8ryMzI=";
    };
    date = "2024-04-29";
  };
  which-key = {
    pname = "which-key";
    version = "1f8d414f61e0b05958c342df9b6a4c89ce268766";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "which-key.nvim";
      rev = "1f8d414f61e0b05958c342df9b6a4c89ce268766";
      fetchSubmodules = false;
      sha256 = "sha256-9V74V01dCqg1w5fpzzCmyfhR3/AYQg2MCIYkkjFv1go=";
    };
    date = "2025-01-05";
  };
  zk-nvim = {
    pname = "zk-nvim";
    version = "10089c398df925b8db51fd659501d2cb044003b9";
    src = fetchFromGitHub {
      owner = "mickael-menu";
      repo = "zk-nvim";
      rev = "10089c398df925b8db51fd659501d2cb044003b9";
      fetchSubmodules = false;
      sha256 = "sha256-i9UOny7vq3O+g0TnL1wwTGnw18g79CyZvOM0kGptt64=";
    };
    date = "2025-01-04";
  };
}
