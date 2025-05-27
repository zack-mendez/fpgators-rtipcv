library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package kernel_pkg is

  type kernel_t is array (0 to 2, 0 to 2) of integer;

  
  -- Debug Filter
  constant DEBUG : kernel_t := (
    (  0,  0,  0 ),
    (  0,  1,  0 ),
    (  0,  0,  0 )
  );

  -- Horizontal Sobel kernel (Gx)
  constant SOBEL_X : kernel_t := (
    ( -1,  0,  1 ),
    ( -2,  0,  2 ),
    ( -1,  0,  1 )
  );

  -- Vertical Sobel kernel (Gy)
  constant SOBEL_Y : kernel_t := (
    (  1,  2,  1 ),
    (  0,  0,  0 ),
    ( -1, -2, -1 )
  );

  -- Prewitt Filter (Gx)
  constant PREWITT_X : kernel_t := (
    ( -1,  0,  1 ),
    ( -1,  0,  1 ),
    ( -1,  0,  1 )
  );

  -- Prewitt Filter (Gy)
  constant PREWITT_Y : kernel_t := (
    (  1,  1,  1 ),
    (  0,  0,  0 ),
    ( -1, -1, -1 )
  );

  -- Laplacian Filter (4-connectivity)
  constant LAPLACIAN_4 : kernel_t := (
    (  0, -1,  0 ),
    ( -1,  4, -1 ),
    (  0, -1,  0 )
  );

  -- Laplacian Filter (8-connectivity)
  constant LAPLACIAN_8 : kernel_t := (
    ( -1, -1, -1 ),
    ( -1,  8, -1 ),
    ( -1, -1, -1 )
  );

  -- Sharpen Filter (mild sharpen)
  constant SHARPEN : kernel_t := (
    (  0, -1,  0 ),
    ( -1,  5, -1 ),
    (  0, -1,  0 )
  );

  -- Strong Sharpen Filter
  constant STRONG_SHARPEN : kernel_t := (
    ( -1, -1, -1 ),
    ( -1,  9, -1 ),
    ( -1, -1, -1 )
  );

  -- Gaussian Blur NEED TO NORMALIZE EXTERNALLY
  constant GAUSSIAN_BLUR : kernel_t := (
    (  1,  2,  1 ),
    (  2,  4,  2 ),
    (  1,  2,  1 )
  );

  -- Emboss Filter
  constant EMBOSS : kernel_t := (
    ( -2, -1,  0 ),
    ( -1,  1,  1 ),
    (  0,  1,  2 )
  );

end package kernel_pkg;
