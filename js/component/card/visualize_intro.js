/**
 * Visualize intro.
 *
 * @param {number} thermostat_id
 */
beestat.component.card.visualize_intro = function(thermostat_id) {
  this.thermostat_id_ = thermostat_id;

  beestat.component.card.apply(this, arguments);
};
beestat.extend(beestat.component.card.visualize_intro, beestat.component.card);

/**
 * Decorate.
 *
 * @param {rocket.Elements} parent
 */
beestat.component.card.visualize_intro.prototype.decorate_contents_ = function(parent) {
  const self = this;

  if (beestat.user.has_early_access() === true) {
    const p1 = document.createElement('p');
    p1.innerText = 'You now have early access to the new Visualize features. This is a work-in-progress, but you should find it to be mostly stable. More features and improvements are in the works.';
    parent.appendChild(p1);

    const p2 = document.createElement('p');
    p2.innerText = 'Please reach out on Discord or email contact@beestat.io with feedback. Thank you for your support!';
    parent.appendChild(p2);

    const center_container = document.createElement('div');
    center_container.style.textAlign = 'center';
    parent.appendChild(center_container);

    new beestat.component.tile()
      .set_icon('plus')
      .set_text('Create a floor plan')
      .set_size('large')
      .set_background_color(beestat.style.color.green.dark)
      .set_background_hover_color(beestat.style.color.green.light)
      .render($(center_container))
      .addEventListener('click', function() {
        new beestat.component.modal.create_floor_plan(
          self.thermostat_id_
        ).render();
      });
  } else {
    parent.style('background', beestat.style.color.green.base);

    const p3 = document.createElement('p');
    p3.innerText = 'This feature is still in early access! If you\'d like to try it out, become a supporter now. Expected public release date is November.';
    parent.appendChild(p3);

    new beestat.component.tile()
      .set_icon('heart')
      .set_size('large')
      .set_text([
        'Support this project on Patreon!',
        'Your contribution matters'
      ])
      .set_background_color(beestat.style.color.green.dark)
      .set_background_hover_color(beestat.style.color.green.light)
      .addEventListener('click', function() {
        window.open('https://www.patreon.com/beestat');
      })
      .render(parent);
  }
};

/**
 * Get the title of the card.
 *
 * @return {string} The title.
 */
beestat.component.card.visualize_intro.prototype.get_title_ = function() {
  return 'Visualize';
};
