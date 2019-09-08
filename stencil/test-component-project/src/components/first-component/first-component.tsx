import { Component, Prop, h } from '@stencil/core';

@Component({
    tag: 'app-first-component',
    styleUrl: 'first-component.css',
    shadow: false
})
export class FirstComponent  {
    @Prop() name: string = 'shufei';

    private getName(): string {
        return this.name + ' hogehogehoge';
    }

    render() {
        return <p class="title">{this.getName()}: aaaaaaaaa!!!</p>
    }
}


