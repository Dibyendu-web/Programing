import solid as sp
import solid.utils as spu

# === Parameters ===
outer_diameter = 20    # Overall diameter of the worm (mm)
height = 10            # Axial length of the worm (mm)
pitch = 4              # Distance between successive thread turns (mm)
hole_diameter = 5      # Diameter of the center hole (mm)

# For a single-start worm, the number of turns is height/pitch.
num_turns = height / pitch  # e.g. 10/4 = 2.5 turns
twist_angle = num_turns * 360  # Total twist angle for the groove cut

# --- Parameters for the groove (thread cut) ---
groove_depth = 1.5     # How deep the groove is (mm)
groove_width = 3       # Approximate width (mm) of the groove along the circumference

# === Build the worm body ===
# This is a simple cylinder representing the bulk of the worm.
worm_body = sp.cylinder(d=outer_diameter, h=height, center=False)

# === Create the groove (thread cut) ===
# We define a 2D profile that will be extruded with a twist to form a helical cut.
#
# The profile is a rectangle positioned so that its right edge lies flush
# with the outer surface (radius = outer_diameter/2) and it extends inward.
profile = sp.polygon(points=[
    (outer_diameter/2 - groove_width, 0),
    (outer_diameter/2, 0),
    (outer_diameter/2, groove_depth),
    (outer_diameter/2 - groove_width, groove_depth)
])

# Use linear_extrude with a twist to sweep the profile along the Z‑axis with rotation.
groove_cut = sp.linear_extrude(height=height, twist=twist_angle)(profile)

# === Subtract the groove from the worm body ===
worm_with_groove = worm_body - groove_cut

# === Create and subtract the central hole ===
center_hole = sp.cylinder(d=hole_diameter, h=height*2, center=True)
final_model = worm_with_groove - center_hole

# === Export the model ===
sp.scad_render_to_file(final_model, "worm_gear.scad")
