import { Component, Host, h } from '@stencil/core';

@Component({
  tag: 'second-component',
  styleUrl: 'second-component.css',
  shadow: true
})
export class SecondComponent {

  render() {
    return (
      <Host>
        <slot></slot>
      </Host>
    );
  }

}
